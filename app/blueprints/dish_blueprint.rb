# frozen_string_literal: true

class DishBlueprint < Blueprinter::Base
  #TODO: will not be working after deploy
  APP_URL = 'http://localhost:3000'

  identifier :id

  fields :name
  field :image do |dish|
    APP_URL + Rails.application.routes.url_helpers.rails_blob_path(dish.image, only_path: true)
  end

  view :with_menus do
    association :menu, blueprint: MenuBlueprint
  end
end
