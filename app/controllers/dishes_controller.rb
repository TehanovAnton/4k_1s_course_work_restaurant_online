class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dish, only: %i[update destroy show]

  def show    
    return render json: @dish

    render json: { error: 'wrong dish params' }
  end

  def create
    authorize Dish
    
    return render json: Dish.create(dish_params)

    render json: { error: 'wrong dish params' }
  end

  def update
    authorize Dish
    response = { error: 'wrong dish params' }

    response = @dish if @dish.update(dish_params)

    render json: response
  end

  def destroy
    authorize Dish
    response = @dish

    response = { error: 'wrong dish params' } unless @dish.destroy

    render json: response
  end

  private

  def set_dish
    @dish = Dish.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong dish params' } unless @dish
  end

  def dish_params
    params.require(:dish).permit(:name, :menu_id)
  end
end
