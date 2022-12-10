
class OrderBlueprint < Blueprinter::Base
  identifier :id

  fields :created_at, :updated_at, :place_type

  association :dishes, blueprint: DishBlueprint
  association :restaurant, blueprint: RestaurantBlueprint
  association :reservations, blueprint: ReservationBlueprint
end
