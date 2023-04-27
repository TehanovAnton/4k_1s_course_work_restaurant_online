USER_NAME_BY_TYPE = {
  'Customer' => 'andrew',
  'Admin' => 'roma',
  'SuperAdmin' => 'anton',
  'Cook' => 'boba'
}.freeze

FactoryBot.define do
  factory :user do
    transient do
      tr_type { 'Customer' }
    end

    name { USER_NAME_BY_TYPE[tr_type] }
    email  { "#{USER_NAME_BY_TYPE[tr_type]}@gmail.com" }
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
