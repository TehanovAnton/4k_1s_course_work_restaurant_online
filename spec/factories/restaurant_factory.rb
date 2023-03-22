FactoryBot.define do
  factory :restaurant do
    name {}
    email {}
    address { 'st.Avenue-15' }

    trait :with_tables do
      tables { (1..10).map { |number| association(:table, number: number) } }
    end

    factory :restaurnat_with_tables, traits: [:with_tables]
  end
end
