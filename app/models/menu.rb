class Menu < ApplicationRecord
  PARAMS = %i[name restaurant_id].freeze
  MODEL_SERIALIZER_CLASS = MenuBlueprint
  MODEL_UPDATER_CLASS = Models::Updaters::Updater
  MODEL_CREATER_CLASS = Models::Creaters::Creater
  MODEL_DESTROYER_CLASS = Models::Destroyers::Destroyer

  include Validations::Menu::MenuValidation

  has_many :dishes, dependent: :destroy
  belongs_to :restaurant

  delegate :admins, to: :restaurant
end
