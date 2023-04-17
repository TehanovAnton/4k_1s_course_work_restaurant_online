# frozen_string_literal:true

class RestaurantsAdminBlueprint < Blueprinter::Base
  identifier :id

  fields :restaurant_id, :user_id
end
