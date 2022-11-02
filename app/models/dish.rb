class Dish < ApplicationRecord
  has_many :orders_dishes
  has_many :orders, through: :orders_dishes

  belongs_to :menu
end
