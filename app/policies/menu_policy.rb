class MenuPolicy < ApplicationPolicy
  def create?
    super_admin? || user.is_a?(Admin)
  end

  def update?
    super_admin? || restaurant_admin?
  end

  def destroy?
    super_admin? || restaurant_admin?
  end

  private

  def restaurant_admin?
    record.admins.include?(user)
  end
end
