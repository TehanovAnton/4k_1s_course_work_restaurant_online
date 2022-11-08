class RestaurantPolicy < ApplicationPolicy
  def create?
    binding.pry
    user.is_a? Admin
  end
end
