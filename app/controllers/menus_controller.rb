class MenusController < DefaultController
  before_action :set_restaurant, only: %i[create can_create?]
  before_action :set_menu, only: %i[update destroy show can_update? can_destroy?]
  before_action :set_authorizer, only: Authorization::MenusAuthorizationApi::ACTIONS

  include Authorization::MenusAuthorizationApi

  def index
    restaurant = Restaurant.includes(:menus).find(params[:restaurant_id])

    @view = request.query_parameters[:view]&.to_sym
    render json: MenuBlueprint.render(restaurant.menus, view: @view)
  end

  def show
    render json: MenuBlueprint.render(@menu, view: :with_dishes)
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

  def authorizable_instance(action)
    case action
    when :create
      Menu
    end
  end

  def creater_service_class
    Models::Creaters::MenuCreater
  end

  def set_menu
    @menu = Menu.includes(:restaurant).find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong menu params' } unless @menu
  end

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])

    update_auth_header
    render json: { error: 'wrong menu params' } unless @restaurant
  end

  def menu_params
    params.require(:menu).permit(:name, :restaurant_id)
  end
end
