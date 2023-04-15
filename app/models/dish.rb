# frozen_string_literal: true

require 'elasticsearch/model'

class Dish < ApplicationRecord
  PARAMS = %i[name menu_id price_cents description image].freeze
  MODEL_SERIALIZER_CLASS = DishBlueprint
  MODEL_UPDATER_CLASS = Models::Updaters::Updater
  MODEL_CREATER_CLASS = Models::Creaters::Creater
  MODEL_DESTROYER_CLASS = Models::Destroyers::ModelResponseDestroyer
  MODEL_ATTACHER_CLASS = Models::Attachers::Attacher

  include Validations::DishValidation::Validation

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :orders_dishes, dependent: :destroy
  has_many :orders, through: :orders_dishes

  has_one_attached :image

  belongs_to :menu

  delegate :admins, to: :menu

  def settings
    {
      index: {
        analysis: {
          analyzer: {
            substring_analyzer: {
              tokenizer: "edge_ngram_tokenizer",
              filter: ["lowercase"]
            }
          },
          tokenizer: {
            edge_ngram_tokenizer: {
              type: "edge_ngram",
              min_gram: 1,
              max_gram: 8,
              token_chars: ["letter", "digit"]
            }
          }
        }
      }
    }
  end

  def mappings
    {
      properties: {
        name: {
          type: "text",
          analyzer: "autocomplete",
          search_analyzer: "autocomplete_search"
        }
      }
    }
  end

  def self.create_index!
    client = __elasticsearch__.client
    index_name = self.index_name

    # Delete the index if it already exists
    client.indices.delete(index: index_name) if client.indices.exists?(index: index_name)

    # Create the index with the new settings and mappings
    client.indices.create(
      index: index_name,
      body: {
        settings: settings.to_hash,
        mappings: mappings.to_hash
      }
    )
  end

  def self.custom_search(query)
    search_definition = {
      query: {
        query_string: {
          query: "*#{query.downcase}*",
          fields: ["name"],
          default_operator: "AND"
        }
      }
    }

    __elasticsearch__.search(search_definition)
  end
end

Dish.create_index!
Dish.import
