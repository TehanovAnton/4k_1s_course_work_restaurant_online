
class Order < ApplicationRecord
  include AASM

  aasm do
    state :active, initial: true
    state :inactive

    event :close do
      transitions from: :active, to: :inactive
    end
  end

  enum place_type: %i[inside outside]

  has_many :orders_dishes, dependent: :destroy
  has_many :dishes, through: :orders_dishes

  has_many :reservations, dependent: :destroy
  has_many :tables, through: :reservations

  belongs_to :restaurant
  belongs_to :user

  accepts_nested_attributes_for :reservations
  accepts_nested_attributes_for :orders_dishes

  delegate :admins, to: :restaurant
end
