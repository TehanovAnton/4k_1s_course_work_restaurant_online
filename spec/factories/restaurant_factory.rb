FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "Restaurant_#{n}" }
    sequence(:email) { "#{name}@example.com" }
    sequence(:address) { |n| "restaurant-#{n}.v" }

    companies_restaurant_attributes { { company_id: Company.last.id } }

    trait :with_tables do
      tables { (1..10).map { |number| association(:table, number: number) } }
    end

    trait :with_menus_and_dishes do
      transient do
        menu_count { 1 }
      end

      menus do
        Array.new(menu_count) { association(:menu_with_dishes) }
      end
    end

    factory :restaurnat_with_tables, traits: [:with_tables]
    factory :restaurnat_with_menus, traits: [:with_tables, :with_menus_and_dishes]
  end
end
