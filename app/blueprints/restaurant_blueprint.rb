
class RestaurantBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :address
  association :tables, blueprint: TableBlueprint

  view :normal do
    association :menus, blueprint: MenuBlueprint, view: :with_dishes
  end
end
