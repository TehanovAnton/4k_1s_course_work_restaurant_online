class Menu < ApplicationRecord
  include Validations::Menu::MenuValidation

  has_many :dishes
  belongs_to :restaurant

  delegate :admins, to: :restaurant
end
