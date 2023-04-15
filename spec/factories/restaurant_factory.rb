FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "Restaurant #{n}" }
    sequence(:email) { |n| "restaurant#{n}@example.com" }
    sequence(:address) { |n| "restaurant-#{n}.v" }

    trait :with_tables do
      tables { (1..10).map { |number| association(:table, number: number) } }
    end

    factory :restaurnat_with_tables, traits: [:with_tables]
  end
end
