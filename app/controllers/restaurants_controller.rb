class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant, only: %i[update destroy show]

  def index
    @restaurants = Restaurant.includes(:menus).all

    render json: RestaurantBlueprint.render(@restaurants)
  end

  def show
    return render json: @restaurant

    render json: { error: 'wrong restaurant params' }
  end

  def create
    authorize Restaurant

    return render json: Restaurant.create(restaurant_params)

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

  def can_create
    authorizer = RestaurantPolicy.new(current_user, Restaurant)

    render json: authorizer.create?
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong restaurant params' } unless @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :email, :address)
  end
end
