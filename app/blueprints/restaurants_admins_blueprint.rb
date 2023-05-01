# frozen_string_literal:true

class RestaurantsAdminsBlueprint < Blueprinter::Base
  identifier :id

  fields :restaurant_id, :user_id

  view :with_user do
    association :admin, blueprint: UserBlueprint, name: :user
  end
end
