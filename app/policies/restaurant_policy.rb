class RestaurantPolicy < ApplicationPolicy
  def create?
    user.is_a?(SuperAdmin)
  end

  def update?
    user.is_a?(SuperAdmin) || record.admins.include?(user)
  end
  
  def destroy?
    user.is_a?(SuperAdmin) || record.admins.include?(user)
  end
end