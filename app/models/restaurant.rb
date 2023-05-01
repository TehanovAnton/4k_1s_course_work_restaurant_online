require 'elasticsearch/model'

class Restaurant < ApplicationRecord
  PARAMS = [
    :name,
    :email,
    :address,
    { restaurants_admins_attributes: %i[user_id] },
    { restaurants_cooks_attributes: %i[id user_id restaurant_id _destroy] }
  ].freeze

  MODEL_SERIALIZER_CLASS = RestaurantBlueprint
  MODEL_UPDATER_CLASS = Models::Updaters::Updater
  MODEL_CREATER_CLASS = Models::Creaters::Creater
  MODEL_DESTROYER_CLASS = Models::Destroyers::ModelResponseDestroyer

  include Validations::RestaurantValidation

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :tables, dependent: :destroy

  has_many :menus, dependent: :destroy
  has_many :dishes, through: :menus

  has_many :orders, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :own_messages, as: :messageble, class_name: 'Message'

  has_many :restaurants_admins, dependent: :destroy
  has_many :admins, through: :restaurants_admins

  has_many :restaurants_cooks, dependent: :destroy
  has_many :cooks, through: :restaurants_cooks

  has_one :companies_restaurant, dependent: :destroy
  has_one :company, through: :companies_restaurant
  has_one :super_admin, through: :company 

  accepts_nested_attributes_for :restaurants_admins
  accepts_nested_attributes_for :restaurants_cooks, allow_destroy: true
  accepts_nested_attributes_for :companies_restaurant

  def all_admins
    admins + [super_admin]
  end

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

Restaurant.create_index!
Restaurant.import
