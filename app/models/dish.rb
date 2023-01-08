class Dish < ApplicationRecord
  PARAMS = %i[name menu_id].freeze
  MODEL_SERIALIZER_CLASS = DishBlueprint
  MODEL_UPDATER_CLASS = Models::Updaters::Updater
  MODEL_CREATER_CLASS = Models::Creaters::Creater

  has_many :orders_dishes, dependent: :destroy
  has_many :orders, through: :orders_dishes

  belongs_to :menu

  delegate :admins, to: :menu
end
