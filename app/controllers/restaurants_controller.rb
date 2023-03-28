class RestaurantsController < Default::Controller
  before_action :authenticate_user!
  before_action :set_model, only: %i[update
                                     destroy
                                     show].concat(Authorization::RestaurantsAuthorizationApi::MODEL_AUTH_ACTIONS)
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
    return render json: RestaurantBlueprint.render(@model)

    render json: { error: 'wrong restaurant params' }
  end

  def destroy
    authorize authorizable_instance(:destroy)

    destroy_service = destroy_service_class.new(@model)
    render(**destroy_service.destroy)
  end

  private

  class << self
    def model_class
      Restaurant
    end
  end

  def authorizable_instance(action)
    case action
    when :create
      self.class.model_class
    when :update, :destroy
      @model
    end
  end

  def set_restaurant
    @restaurant = Restaurant.includes(:own_messages).find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong restaurant params' } unless @restaurant
  end
end
