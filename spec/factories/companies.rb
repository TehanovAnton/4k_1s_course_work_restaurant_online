FactoryBot.define do
  factory :company do
    sequence :name do |n|
      "Company-#{n}"
    end

    sequence :email do |n|
      "company#{n}@example.com"
    end

    super_admins_company do 
      association :super_admins_company, user_id: SuperAdmin.last.id
    end

    trait :admin_nested_attributes do
      super_admins_company_attributes { { user_id: SuperAdmin.last.id } }
    end
  end
end
