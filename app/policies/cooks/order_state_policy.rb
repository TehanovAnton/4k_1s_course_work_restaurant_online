# frozen_string_literal:true

module Cooks
  class OrderStatePolicy < CookPolicy
    def transition?
      cook? && refers_to_order_restaurant?
    end

    private

    def record_restaurant
      @record_restaurant ||= Restaurant.joins(orders: [:order_state])
                                       .where("order_states.id = #{record.id}")
                                       .select(:id)
                                       .first
    end
  end
end
