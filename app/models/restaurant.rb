class Restaurant < ApplicationRecord
  include Validations::RestaurantValidation

  has_many :tables, dependent: :destroy

  has_many :menus, dependent: :destroy
  has_many :dishes, through: :menus

  has_many :orders, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :own_messages, as: :messageble, class_name: 'Message'

  has_many :restaurants_admins, dependent: :destroy
  has_many :admins, through: :restaurants_admins
end
