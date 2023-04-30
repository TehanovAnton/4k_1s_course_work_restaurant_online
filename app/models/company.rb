class Company < ApplicationRecord
  has_one :super_admins_company, dependent: :destroy
  has_one :super_admin, through: :super_admins_company, dependent: :destroy

  has_many :companies_restaurants, dependent: :destroy
  has_many :restaurants, through: :companies_restaurants, dependent: :destroy

  validates_presence_of :super_admins_company, message: proc {
    "Could not create company without user binding"
  }

  validates :name, :email, presence: {
    message: lambda do |_, data|
      "Could not create #{data[:model]} without #{data[:attribute]}"
    end
  }

  accepts_nested_attributes_for :super_admins_company 
end
