class ReservationPolicy < ApplicationPolicy
  def update?
    user.is_a?(SuperAdmin) || record.admins.include?(user) || user.orders.include?(record)
  end
  
  def destroy?
    user.is_a?(SuperAdmin) || record.admins.include?(user) || user.orders.include?(record)
  end
end
