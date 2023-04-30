class SuperAdminsCompany < ApplicationRecord
  belongs_to :super_admin, class_name: 'SuperAdmin', foreign_key: 'user_id', optional: true
  belongs_to :company, optional: true

  validates_presence_of :super_admin, message: proc {
    "is missing"
  }

  validates :user_id, uniqueness: {
    message: lambda do |_, data|
      "Company can have only one super admin account."
    end
  }
end
