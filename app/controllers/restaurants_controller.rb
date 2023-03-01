class RestaurantsController < DefaultController
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
    return render json: RestaurantBlueprint.render(@restaurant)

    render json: { error: 'wrong restaurant params' }
  end

  def destroy
    authorize @restaurant
    response = @restaurant

    response = { error: 'wrong restaurant params' } unless @restaurant.destroy

    render json: response
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

  def restaurant_params
    params.require(:restaurant).permit(:name, :email, :address)
  end
end
