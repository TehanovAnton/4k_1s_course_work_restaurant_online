class MenusController < Default::Controller
  before_action :set_model, only: %i[update
                                     destroy
                                     show].concat(Authorization::MenusAuthorizationApi::MODEL_AUTH_ACTIONS)
  before_action :set_restaurant, only: %i[create].concat(Authorization::MenusAuthorizationApi::MODEL_AUTH_CREATE_ACTION)

  include Authorization::MenusAuthorizationApi

  def index
    restaurant = Restaurant.includes(:menus).find(params[:restaurant_id])

    @view = request.query_parameters[:view]&.to_sym
    render json: MenuBlueprint.render(restaurant.menus, view: @view)
  end

  def show
    render json: MenuBlueprint.render(@model, view: :with_dishes)
  end

  def destroy
    authorize authorizable_instance(:destroy)

    destroy_service = destroy_service_class.new(@model)
    render(**destroy_service.destroy)
  end

  private

  class << self
    def model_class
      Menu
    end
  end

  def authorizable_instance(action)
    case action
    when :create
      Menu
    when :update
      @model
    when :destroy
      @model
    end
  end

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])

    update_auth_header
    render json: { error: 'wrong menu params' } unless @restaurant
  end
end
