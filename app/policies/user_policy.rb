class UserPolicy < ApplicationPolicy
  def create?
    user.is_a? Admin
  end

  def update?
    user.is_a? Admin || user.id == record.id
  end
  
  def destroy?
    user.is_a? Admin || user.id == record.id
  end
end
