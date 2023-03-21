# frozen_string_literal: true

class Dish < ApplicationRecord
  PARAMS = %i[name menu_id price_cents].freeze
  MODEL_SERIALIZER_CLASS = DishBlueprint
  MODEL_UPDATER_CLASS = Models::Updaters::Updater
  MODEL_CREATER_CLASS = Models::Creaters::Creater
  MODEL_DESTROYER_CLASS = Models::Destroyers::ModelResponseDestroyer
  MODEL_ATTACHER_CLASS = Models::Attachers::Attacher

  include Validations::DishValidation::Validation

  has_many :orders_dishes, dependent: :destroy
  has_many :orders, through: :orders_dishes

  has_one_attached :image

  belongs_to :menu

  delegate :admins, to: :menu
end
