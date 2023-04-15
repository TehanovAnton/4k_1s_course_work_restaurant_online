
class MenuBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  association :restaurant, blueprint: RestaurantBlueprint

  view :with_dishes do
    association :dishes, blueprint: DishBlueprint
  end

  view :search do
    association :restaurant, blueprint: RestaurantBlueprint, view: :search
  end
end
