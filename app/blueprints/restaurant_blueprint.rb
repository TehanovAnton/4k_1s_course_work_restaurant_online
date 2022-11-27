
class RestaurantBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :address

  association :menus, blueprint: MenuBlueprint
end
