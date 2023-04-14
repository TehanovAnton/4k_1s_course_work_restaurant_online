class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :type

  view :cook do
    association :restaurant, blueprint: RestaurantBlueprint
  end
end
