class Menu < ApplicationRecord
  has_many :dishes
  belongs_to :restaurant

  delegate :admins, to: :restaurant
end
