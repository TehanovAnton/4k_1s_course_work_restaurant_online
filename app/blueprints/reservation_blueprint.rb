
class ReservationBlueprint < Blueprinter::Base
  identifier :id

  fields :start_at, :end_at

  association :table, blueprint: TableBlueprint
end
