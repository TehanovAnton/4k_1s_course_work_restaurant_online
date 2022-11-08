class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize Restaurant
    
    return render json: Restaurant.create(restaurant_params)

    render json: { error: 'wrong restaurant params' }
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :email, :address)
  end
end
