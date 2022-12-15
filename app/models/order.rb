
class Order < ApplicationRecord
  PARAMS = [
    :user_id,
    :restaurant_id,
    { orders_dishes_attributes: %i[dish_id] },
    { reservations_attributes: %i[table_id start_at end_at place_type] }
  ]

  include AASM

  aasm do
    state :active, initial: true
    state :canceled
    state :completed

    event :cancel do
      transitions from: :active, to: :canceled
    end

    event :complete do
      transitions from: :active, to: :completed
    end
  end

  has_many :orders_dishes, dependent: :destroy
  has_many :dishes, through: :orders_dishes

  has_many :reservations, dependent: :destroy
  has_many :tables, through: :reservations

  has_many :menus, through: :dishes

  has_one :rating, dependent: :destroy

  belongs_to :restaurant
  belongs_to :user

  accepts_nested_attributes_for :reservations
  accepts_nested_attributes_for :orders_dishes

  delegate :admins, to: :restaurant
end
