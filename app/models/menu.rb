class Menu < ApplicationRecord
  has_many :dishes
  belongs_to :restaurant
end
