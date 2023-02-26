class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant, only: %i[update destroy show can_update? can_destroy? post_message delete_message
                                          restaurant_messages]
  before_action :set_message, only: %i[delete_message]
  before_action :set_authorizer, only: Authorization::RestaurantsAuthorizationApi::ACTIONS

  include Authorization::RestaurantsAuthorizationApi
  include Messageble::RestaurantsMessagesApi
  include Searchable::RestaurantsSearchApi

  def index
    @restaurants = Restaurant.includes(:menus).all
    view = params['resataurant_view'] || 'default'

    render json: RestaurantBlueprint.render(@restaurants, view: view.to_sym)
  end

  def show
    return render json: RestaurantBlueprint.render(@restaurant)

    render json: { error: 'wrong restaurant params' }
  end

  def create
    authorize Restaurant

    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      @restaurant.admins << current_user
      return render json: @restaurant
    end

    render json: { error: 'wrong restaurant params' }
  end

  def update
    authorize @restaurant
    response = { error: 'wrong restaurant params' }

    response = @restaurant if @restaurant.update(restaurant_params)

    render json: response
  end

  def destroy
    authorize @restaurant
    response = @restaurant

    response = { error: 'wrong restaurant params' } unless @restaurant.destroy

    render json: response
  end

  private

  def set_restaurant
    @restaurant = Restaurant.includes(:own_messages).find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong restaurant params' } unless @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :email, :address)
  end
end
