USER_NAME_BY_TYPE = {
  'Customer' => 'andrew',
  'Admin' => 'roma',
  'SuperAdmin' => 'antont'
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
end