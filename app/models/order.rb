class Order < ApplicationRecord
  has_many :reservations
  has_many :tables, through: :reservations

  belongs_to :restaurant
  belongs_to :user
end
