# frozen_string_literal:true

class OrderStatePolicy < ApplicationPolicy
  def transition?
    cook? && refers_to_order_restaurant?
  end

  private

  def cook?
    user.is_a? Cook
  end

  def order_restaurant
    Restaurant.joins(orders: [:order_state])
              .where("order_states.id = #{record.id}")
              .select(:id)
              .first
  end

  def refers_to_order_restaurant?
    # I use joind table model because Cook joins by has_one asscociation.
    RestaurantsCook.where(id: order_restaurant.id)
                   .joins(:restaurant)
                   .ids
                   .include?(user.restaurants_cook.id)
  end
end
