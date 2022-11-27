class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_menu, only: %i[update destroy show]

  def show
    return render json: @menu

    render json: { error: 'wrong menu params' }
  end

  def create
    authorize Menu
    
    return render json: Menu.create(menu_params)

    render json: { error: 'wrong menu params' }
  end

  def update
    authorize @menu
    response = { error: 'wrong menu params' }

    response = @menu if @menu.update(menu_params)

    render json: response
  end

  def destroy
    authorize @menu
    response = @menu

    response = { error: 'wrong menu params' } unless @menu.destroy

    render json: response
  end

  private

  def set_menu
    @menu = Menu.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong menu params' } unless @menu
  end

  def menu_params
    params.require(:menu).permit(:name, :restaurant_id)
  end
end
