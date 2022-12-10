
class ReservationBlueprint < Blueprinter::Base
  identifier :id
  
  fields :start_at, :end_at, :place_type

  association :table, blueprint: TableBlueprint
end
