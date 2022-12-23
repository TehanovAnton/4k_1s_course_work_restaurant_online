class Restaurant < ApplicationRecord
  include Validations::RestaurantValidation

  has_many :tables
  has_many :menus, dependent: :destroy
  has_many :orders
  has_many :messages
  has_many :own_messages, as: :messageble, class_name: 'Message'

  has_many :restaurants_admins, dependent: :destroy
  has_many :admins, through: :restaurants_admins
end
