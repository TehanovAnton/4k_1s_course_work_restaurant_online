
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

  def team?
    restaurant_admin?
  end

  def create_cook?
    restaurant_admin?
  end

  private

  def super_admin?
    user.is_a? SuperAdmin
  end

  def restaurant_admin?
    admins_ids = record.admins.ids << record.company.super_admin.id
    admins_ids.include?(user.id)
  end
end
