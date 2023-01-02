FactoryBot.define do
  factory :restaurant do
    name { 'Avenue' }
    email  { 'avenue@gmail.com' }
    address { 'st.Avenue-15' }

    trait :with_tables do
      tables { (1..10).map { |number| association(:table, number: number) } }
    end
  end
end
