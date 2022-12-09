
class DishBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  view :with_menus do
    association :menu, blueprint: MenuBlueprint
  end
end
