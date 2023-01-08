class DishesController < DefaultController
  before_action :set_model, only: %i[update
                                     destroy
                                     show].concat(Authorization::DishesAuthorizationApi::MODEL_AUTH_ACTIONS)
  before_action :set_menu, only: %i[index
                                    create].concat(Authorization::DishesAuthorizationApi::MODEL_AUTH_CREATE_ACTION)

  include Authorization::DishesAuthorizationApi

  def index
    @view = request.query_parameters[:view]&.to_sym
    render json: DishBlueprint.render(@menu.dishes, view: @view)
  end

  def show
    return render json: @dish

    render json: { error: 'wrong dish params' }
  end

  private

  class << self
    def model_class
      Dish
    end
  end

  def set_menu
    @menu = Menu.includes(:dishes).find(params[:menu_id])

    update_auth_header
    render json: { error: 'wrong dish params' } unless @menu
  end

  def authorizable_instance(action)
    case action
    when :create
      self.class.model_class
    when :update
      @model
    when :destroy
      @model
    end
  end
end
