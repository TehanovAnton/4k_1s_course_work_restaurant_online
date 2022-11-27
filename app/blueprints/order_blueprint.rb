
class OrderBluePrint < Blueprinter::Base
  identifier :id

  fields :created_at, :updated_at

  association :dishes, blueprint: DishBlueprint
end
