class UserPolicy < ApplicationPolicy
  def create?
    super_admin?
  end

  def update?
    super_admin? || user.id == record.id
  end

  def destroy?
    user.is_a?(SuperAdmin) || user.id == record.id
  end

  class Scope < Scope
    def resolve
      if super_admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
