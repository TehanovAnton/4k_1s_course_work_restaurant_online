class Menu < ApplicationRecord
  PARAMS = %i[name restaurant_id].freeze

  include Validations::Menu::MenuValidation

  has_many :dishes
  belongs_to :restaurant

  delegate :admins, to: :restaurant
end
