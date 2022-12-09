
class MenuBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  association :restaurant, blueprint: RestaurantBlueprint

  view :with_dishes do
    association :dishes, blueprint: DishBlueprint
  end
end
