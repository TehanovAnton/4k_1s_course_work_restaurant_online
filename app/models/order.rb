class Order < ApplicationRecord
  has_many :orders_dishes
  has_many :dishes, through: :orders_dishes

  has_many :reservations
  has_many :tables, through: :reservations

  belongs_to :restaurant
  belongs_to :user
end
