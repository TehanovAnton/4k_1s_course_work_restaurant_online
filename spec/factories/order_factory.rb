# frozen_literal_string:true

FactoryBot.define do
  factory :order do
    user_id { Customer.last.id }
    restaurant_id { Restaurant.last.id }
    
    trait :outside_order_reservation do
      association :reservation, factory: :outside_reservation
    end

    trait :inside_order_reservation do
      association :reservation, factory: :inside_reservation
    end

    trait :reservation_attributes do
      transient do
        table { restaurant.tables.first }
      end

      reservation_attributes do
        {
          start_at: DateTime.now + 2.hours,
          end_at: DateTime.now + 2.hours,
          table_id: table.id,
          place_type: :inside
        }
      end
    end

    trait :dishes do
      dishes { [Dish.last] }
    end

    factory :outside_order, traits: [:outside_order_reservation, :dishes]
    factory :inside_order_through_attributes, traits: [:reservation_attributes]
  end
end
