class DishPolicy < ApplicationPolicy
  def create?
    super_admin? || user.is_a?(Admin)
  end

  def update?
    super_admin? || record.admins.include?(user)
  end

  def destroy?
    super_admin? || record.admins.include?(user)
  end

  def attache_image?
    super_admin? || record.admins.include?(user)
  end
end
