# frozen-string_literal:true

class RatingPolicy < ApplicationPolicy
  def create?
    customer?
  end

  def update?
    customer? && referres_to_order_customer?
  end

  def destroy?
    true
  end

  private

  def record_order
    record.order
  end

  def referres_to_order_customer?
    Order.where(user_id: user.id)
         .ids
         .include?(record_order.id)
  end
end
