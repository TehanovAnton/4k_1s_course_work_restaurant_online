FactoryBot.define do
  factory :user do
    transient do
      tr_type { 'Customer' }
    end

    sequence :name do |n|
      "#{tr_type}_#{n}"
    end

    sequence :email do
      "#{name}_company@gmail.com"
    end

    password { 'ewqqwe' }
    password_confirmation { 'ewqqwe' }
    type { tr_type }
  end

  factory :cook do
    transient do
      tr_type { 'Cook' }
    end

    name { USER_NAME_BY_TYPE[tr_type] }
    email  { "#{USER_NAME_BY_TYPE[tr_type]}@gmail.com" }
    password { 'ewqqwe' }
    password_confirmation { 'ewqqwe' }
    cook_user_binding_attributes { { user_id: Customer.last.id } }
    type { tr_type }
  end
end
