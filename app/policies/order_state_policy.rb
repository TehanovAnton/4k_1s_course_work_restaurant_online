# frozen_string_literal:true

class OrderStatePolicy < ApplicationPolicy
  def transition?
    user.is_a? Cook
  end
end
