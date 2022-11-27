class RestaurantPolicy < ApplicationPolicy
  def create?
    [SuperAdmin, Admin].include? user.class
  end

  def update?
    user.is_a?(SuperAdmin) || record.admins.include?(user)
  end

  def destroy?
    user.is_a?(SuperAdmin) || record.admins.include?(user)
  end
end
