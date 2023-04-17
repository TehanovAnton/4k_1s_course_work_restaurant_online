class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :type

  view :cook do
    association :restaurants_cook, blueprint: RestaurantsCookBlueprint
    association :restaurant, blueprint: RestaurantBlueprint
  end

  view :admin do
    association :restaurants_admins, blueprint: RestaurantsAdminsBlueprint
    association :restaurants, blueprint: RestaurantBlueprint
  end
end
