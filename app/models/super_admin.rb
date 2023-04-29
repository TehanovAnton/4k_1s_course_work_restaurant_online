class SuperAdmin < Admin
  has_one :super_admins_company, dependent: :destroy, foreign_key: 'user_id'

  has_one :company,
          through: :super_admins_company,
          dependent: :destroy
end
