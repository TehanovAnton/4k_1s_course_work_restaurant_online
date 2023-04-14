
class OrderBlueprint < Blueprinter::Base
  identifier :id

  fields :created_at, :updated_at, :restaurant_id, :user_id

  field :order_dishes_attributes do |order|
    order.dishes.map { |d| { dish_id: d.id } }
  end

  association :orders_dishes, blueprint: OrdersDishes
  association :dishes, blueprint: DishBlueprint
  association :reservation, blueprint: ReservationBlueprint
  association :table, blueprint: TableBlueprint
  association :rating, blueprint: RatingBlueprint
  association :order_state, blueprint: OrderStateBlueprint
end
