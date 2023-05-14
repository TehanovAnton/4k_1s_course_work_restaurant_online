# frozen-string_literal:true

class RatingPolicy < ReferrersPolicy
  REFERRED_MODEL = Order

  def create?
    customer? || super_admin?
  end

  def update?
    customer? && referres_to_reffered_model?
  end

  def destroy?
    referres_to_reffered_model?
  end

  private

  def reffered_record
    record.order
  end

  def user_referred_filter
    { user_id: user.id }
  end
end
