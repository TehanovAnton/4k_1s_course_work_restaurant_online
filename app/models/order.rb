class Order < ApplicationRecord
  has_many :orders_dishes, dependent: :destroy
  has_many :dishes, through: :orders_dishes

  has_many :reservations, dependent: :destroy
  has_many :tables, through: :reservations

  belongs_to :restaurant
  belongs_to :user

  accepts_nested_attributes_for :reservations
  # when orders would have state allow_destroy: true
  accepts_nested_attributes_for :orders_dishes
end
