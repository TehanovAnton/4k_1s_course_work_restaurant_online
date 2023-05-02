FactoryBot.define do
  factory :dish do
    sequence :name do |n|
      "Dish_#{n}"
    end

    menu_id { Menu.last&.id }
  end
end
