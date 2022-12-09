class DishPolicy < ApplicationPolicy
  def create?
    super_admin? || record.admins.include?(user)
  end

  def update?
    super_admin? || record.admins.include?(user)
  end

  def destroy?
    super_admin? || record.admins.include?(user)
  end
end
