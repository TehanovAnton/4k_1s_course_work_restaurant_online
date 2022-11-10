class MenuPolicy < ApplicationPolicy
  def create?
    user.is_a?(SuperAdmin) || record.restaurant.admins.include?(user)
  end

  def update?
    user.is_a?(SuperAdmin) || record.restaurant.admins.include?(user)
  end
  
  def destroy?
    user.is_a?(SuperAdmin) || record.restaurant.admins.include?(user)
  end
end
