
class OrderBlueprint < Blueprinter::Base
  identifier :id

  fields :created_at, :updated_at, :restaurant_id, :user_id

  association :orders_dishes, blueprint: OrdersDishes
  association :dishes, blueprint: DishBlueprint
  association :reservation, blueprint: ReservationBlueprint
  association :table, blueprint: TableBlueprint
end
