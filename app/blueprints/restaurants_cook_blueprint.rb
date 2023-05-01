# frozen_string_literal:true

class RestaurantsCookBlueprint < Blueprinter::Base
  identifier :id

  fields :restaurant_id, :user_id

  view :with_user do
    association :cook, blueprint: UserBlueprint, name: :user
  end
end
