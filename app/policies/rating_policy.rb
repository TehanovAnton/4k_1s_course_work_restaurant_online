# frozen-string_literal:true

class RatingPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    true
  end
end
