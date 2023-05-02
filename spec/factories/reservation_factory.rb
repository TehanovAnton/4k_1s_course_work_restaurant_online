FactoryBot.define do
  factory :reservation do
    start_at { DateTime.now + 2.hours }
    end_at { DateTime.now + 3.hours }

    trait :inside_place_type do
      place_type { :inside }
      table_id {}
    end

    trait :outside_place_type do
      place_type { :outside }
    end

    factory :outside_reservation, traits: [:outside_place_type]
    factory :inside_reservation, traits: [:inside_place_type]
  end
end
