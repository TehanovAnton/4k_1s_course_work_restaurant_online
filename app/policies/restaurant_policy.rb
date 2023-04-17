
class RestaurantPolicy < ApplicationPolicy
  def create?
    [SuperAdmin, Admin].include? user.class
  end

  def update?
    record.admins.ids.include?(user.id)
  end

  def destroy?
    record.admins.ids.include?(user.id)
  end

  private

  def super_admin?
    user.is_a? SuperAdmin
  end
end
