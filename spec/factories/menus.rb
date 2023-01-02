FactoryBot.define do
  factory :menu do
    name { 'Breakfast' }
    restaurant_id { Restaurant.last.id }
  end
end
