class Table < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :orders, through: :reservations

  belongs_to :restaurant
end
