
class OrdersDishes < Blueprinter::Base
  identifier :id

  association :dish, blueprint: DishBlueprint
end
