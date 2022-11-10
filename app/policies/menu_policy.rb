class MenuPolicy < ApplicationPolicy
  def create?
    user.is_a? Admin
  end

  def update?
    user.is_a? Admin
  end
  
  def destroy?
    user.is_a? Admin
  end
end
