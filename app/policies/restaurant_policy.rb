
class RestaurantPolicy < ApplicationPolicy
  def create?
    [SuperAdmin, Admin].include? user.class
  end

  def update?
    super_admin? || record.admins.ids.include?(user.id)
  end

  def destroy?
    super_admin? || record.admins.ids.include?(user.id)
  end

  private

  def super_admin?
    user.is_a? SuperAdmin
  end
end
