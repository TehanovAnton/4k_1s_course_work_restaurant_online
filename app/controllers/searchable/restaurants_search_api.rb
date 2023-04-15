module Searchable::RestaurantsSearchApi
  def search
    match_expression = params[:match_expression]

    2.times do
      @restaurants = Restaurant.custom_search(match_expression).records.to_a
      @dishes = Dish.custom_search(match_expression).records.to_a
    end

    restaurants_hash = RestaurantBlueprint.render_as_hash(@restaurants, view: :search)
    dishes_hash = DishBlueprint.render_as_hash(@dishes, view: :search)
    searched_models_hash = restaurants_hash.concat(dishes_hash)

    render json: searched_models_hash
  end
end
