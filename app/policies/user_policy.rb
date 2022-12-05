class UserPolicy < ApplicationPolicy
  def create?
    user.is_a?(SuperAdmin)
  end

  def update?
    user.is_a?(SuperAdmin) || user.id == record.id
  end

  def destroy?
    user.is_a?(SuperAdmin) || user.id == record.id
  end
end
