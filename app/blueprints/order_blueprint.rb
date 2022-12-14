
class OrderBlueprint < Blueprinter::Base
  identifier :id

  fields :created_at, :updated_at, :restaurant_id, :user_id

  # association :dishes, blueprint: DishBlueprint
  association :orders_dishes, blueprint: OrdersDishes
  association :user, blueprint: UserBlueprint
  association :menus, blueprint: MenuBlueprint
  association :restaurant, blueprint: RestaurantBlueprint
  association :reservations, blueprint: ReservationBlueprint
end
