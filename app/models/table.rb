class Table < ApplicationRecord
  has_many :reservations
  has_many :orders, through: :reservations

  belongs_to :restaurant
end
