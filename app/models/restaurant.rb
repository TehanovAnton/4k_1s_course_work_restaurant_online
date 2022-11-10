class Restaurant < ApplicationRecord
  has_many :tables
  has_many :menus, dependent: :destroy
  has_many :orders
  has_many :messages

  has_many :restaurants_admins
  has_many :admins, through: :restaurants_admins
end
