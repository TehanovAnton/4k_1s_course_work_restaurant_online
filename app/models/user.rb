class User < ApplicationRecord
  PARAMS = [
    :name,
    :email,
    :password,
    :password_confirmation,
    :type,
    cook_user_binding_attributes: [:user_id],
    restaurants_cook_attributes: [:restaurant_id]
  ]

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :orders, dependent: :destroy
  has_many :messages, dependent: :destroy
end
