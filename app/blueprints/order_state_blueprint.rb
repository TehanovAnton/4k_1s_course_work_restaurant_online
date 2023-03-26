# frozen_string_literal:true
class OrderStateBlueprint < Blueprinter::Base
  identifier :id

  fields :aasm_state, :order_id
end
