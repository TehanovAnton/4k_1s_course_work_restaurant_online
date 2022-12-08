
class DishBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  view :normal do
    association :menu, blueprint: MenuBlueprint
  end
end
