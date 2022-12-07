
class RestaurantBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :address

  view :normal do
    association :menus, blueprint: MenuBlueprint
  end
end
