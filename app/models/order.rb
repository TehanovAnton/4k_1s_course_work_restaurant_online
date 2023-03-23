# frozen_string_literal:true

class Order < ApplicationRecord
  ORDER_DISHES_PARAMS = { orders_dishes_attributes: %i[id dish_id] }.freeze
  PARAMS = [
    :user_id,
    :restaurant_id,
    ORDER_DISHES_PARAMS,
    { reservation_attributes: %i[id table_id start_at end_at place_type] }
  ].freeze
  MODEL_SERIALIZER_CLASS = OrderBlueprint
  MODEL_UPDATER_CLASS = Models::Updaters::UpdaterWithOnValidation
  MODEL_CREATER_CLASS = Models::Creaters::Creater
  MODEL_DESTROYER_CLASS = Models::Destroyers::ModelResponseDestroyer

  include Validations::OrderValidation::Validation

  has_many :orders_dishes, dependent: :destroy
  has_many :dishes, through: :orders_dishes

  has_one :reservation, dependent: :destroy
  has_one :table, through: :reservation
  has_one :order_state

  has_many :menus, through: :dishes
  has_many :messages, as: :messageble
  has_one :rating, dependent: :destroy

  belongs_to :restaurant
  belongs_to :user

  accepts_nested_attributes_for :reservation
  accepts_nested_attributes_for :orders_dishes

  delegate :admins, to: :restaurant
end
