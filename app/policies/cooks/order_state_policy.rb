# frozen_string_literal:true

module Cooks
  class OrderStatePolicy < ReferrersPolicy
    REFERRED_MODEL = Restaurant

    def transition?
      cook? && referres_to_reffered_model?
    end

    private

    def reffered_record
      Restaurant.joins(orders: [:order_state])
                .where("order_states.id = #{record.id}")
                .first
    end

    def user_referred_filter
      { id: user.restaurant.id }
    end
  end
end
