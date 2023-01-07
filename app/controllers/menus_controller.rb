class MenusController < DefaultController
  MODEL = Menu

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

  private

  def authorizable_instance(action)
    case action
    when :create
      Menu
    when :update
      @menu
    when :destroy
      @menu
    end
  end

  def updater_service_class
    Models::Updaters::MenuUpdater
  end

  def creater_service_class
    Models::Creaters::MenuCreater
  end

  def destroy_service_class
    Models::Destroyers::MenuDestroyer
  end

  def set_menu
    @model = @menu = Menu.includes(:restaurant).find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong menu params' } unless @menu
  end

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])

    update_auth_header
    render json: { error: 'wrong menu params' } unless @restaurant
  end
end
