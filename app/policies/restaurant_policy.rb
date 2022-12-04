class RestaurantPolicy < ApplicationPolicy
  def create?
    [SuperAdmin, Admin].include? user.class
  end

  def update?
    [SuperAdmin, Admin].include? user.class
  end

  def destroy?
    [SuperAdmin, Admin].include? user.class
  end
end
