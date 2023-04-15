# frozen_string_literal: true

class DishBlueprint < Blueprinter::Base
  #TODO: will not be working after deploy
  APP_URL = 'http://localhost:3000'

  identifier :id

  fields :name, :price_cents, :price_currency, :description, :menu_id

  field :image, if: ->(_, dish, _) { dish.image.attached? } do |dish|
    image_path = Rails.application.routes.url_helpers.rails_blob_path(dish.image, only_path: true)
    APP_URL + image_path
  end

  view :with_menus do
    association :menu, blueprint: MenuBlueprint
  end

  view :search do
    field :type do |restaurant|
      restaurant.class.name
    end

    association :menu, blueprint: MenuBlueprint, view: :search
  end
end
