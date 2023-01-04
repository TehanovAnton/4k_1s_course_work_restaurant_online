FactoryBot.define do
  factory :reservation do
    start_at {}
    end_at {}
    order

    trait :inside do
      place_type { :inside }
      table_id {}
    end

    trait :outside do
      place_type { :outside }
    end
  end
end
