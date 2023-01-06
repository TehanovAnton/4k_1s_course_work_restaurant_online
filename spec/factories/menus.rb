BREAKFAST_MEALS = ['coffee', 'poriddge', 'toasts', 'milk', 'banana']

FactoryBot.define do
  factory :menu do
    name { 'Breakfast' }
    restaurant_id { Restaurant.last.id }

    trait :breakfast do
      dishes do
        BREAKFAST_MEALS.map { |meal| association(:dish, name: meal) }
      end
    end
  end
end
