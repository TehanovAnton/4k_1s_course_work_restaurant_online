
FactoryBot.define do
  factory :menu do
    sequence :name do |n|
      "Menu_#{n}"
    end

    restaurant_id { Restaurant.last&.id }

    trait :dishes do
      transient do
        dishes_count { 1 }
      end

      dishes do
        Array.new(dishes_count) do
          association(:dish)
        end
      end
    end

    factory :menu_with_dishes, traits: [:dishes]
  end
end
