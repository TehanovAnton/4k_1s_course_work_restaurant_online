class OrderPolicy < ApplicationPolicy
  def show?
    super_admin? || record.admins.include?(user) || user.orders.include?(record)
  end

  def update?
    super_admin? || record.admins.include?(user) || user.orders.include?(record)
  end

  def destroy?
    super_admin? || record.admins.include?(user) || user.orders.include?(record)
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
