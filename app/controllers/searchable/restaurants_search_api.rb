module Searchable::RestaurantsSearchApi
  def search
    @match_expression = params[:match_expression]
    @restaurants = Restaurant.where("name like '%#{@match_expression}%'")

    render json: RestaurantBlueprint.render(@restaurants)
  end
end
