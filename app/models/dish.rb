class Dish < ApplicationRecord
  PARAMS = %i[name menu_id].freeze
  MODEL_SERIALIZER_CLASS = DishBlueprint

  has_many :orders_dishes, dependent: :destroy
  has_many :orders, through: :orders_dishes

  belongs_to :menu

  delegate :admins, to: :menu
end
