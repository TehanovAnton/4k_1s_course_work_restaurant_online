FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "Restaurant_#{n}" }
    sequence(:email) { "#{name}@example.com" }
    sequence(:address) { |n| "restaurant-#{n}.v" }

    companies_restaurant_attributes { { company_id: Company.last.id } }

    trait :with_tables do
      tables { (1..10).map { |number| association(:table, number: number) } }
    end

    factory :restaurnat_with_tables, traits: [:with_tables]
  end
end
