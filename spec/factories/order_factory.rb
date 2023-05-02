# frozen_literal_string:true

FactoryBot.define do
  factory :order do
    user_id { Customer.last.id }
    restaurant_id { Restaurant.last.id }
    
    trait :outside_order_reservation do
      association :reservation, factory: :outside_reservation
    end

    trait :dishes do
      dishes { [Dish.last] }
    end

    factory :outside_order, traits: [:outside_order_reservation, :dishes]
  end
end
