
class CompanyPolicy < ReferrersPolicy
  REFERRED_MODEL = SuperAdmin

  def create?
    super_admin?
  end

  def update?
    super_admin? && referres_to_reffered_model?
  end

  private 

  def reffered_record
    REFERRED_MODEL.joins(:super_admins_company)
                  .where("super_admins_companies.company_id = #{record.id}")
                  .first
  end

  def user_referred_filter
    { id: user.id }
  end
end
