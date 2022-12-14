class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_menu, only: %i[index create can_create?]
  before_action :set_dish, only: %i[update destroy show can_destroy? can_update?]
  before_action :set_authorizer, only: Authorization::DishesAuthorizationApi::ACTIONS

  include Authorization::DishesAuthorizationApi

  def index
    @view = request.query_parameters[:view]&.to_sym
    render json: DishBlueprint.render(@menu.dishes, view: @view)
  end

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
    authorize @dish
    response = { error: 'wrong dish params' }

    response = @dish if @dish.update(dish_params)

    render json: response
  end

  def destroy
    authorize @dish

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

  def set_menu
    @menu = Menu.includes(:dishes).find(params[:menu_id])

    update_auth_header
    render json: { error: 'wrong dish params' } unless @menu
  end

  def dish_params
    params.require(:dish).permit(:name, :menu_id)
  end
end
