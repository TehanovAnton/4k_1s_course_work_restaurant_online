# frozen_string_literal:true

class OrdersController < Notify::Controller
  before_action :set_model, only: %i[update
                                     destroy
                                     show].concat(Authorization::OrdersAuthorizationApi::MODEL_AUTH_ACTIONS)
  before_action :set_user, only: %i[index create can_create?]
  before_action :set_message, only: %i[delete_message]
  before_action :set_authorizer, only: Authorization::OrdersAuthorizationApi::ACTIONS

  include Authorization::OrdersAuthorizationApi
  include Messageble::OrdersMessagesApi

  def index
    @scope = if current_user.is_a?(SuperAdmin)
      Order.where(user_id: params[:user_id])
    else
      current_user.orders
    end

    render json: OrderBlueprint.render(@scope)
  end

  def show
    authorize @order

    return render json: OrderBlueprint.render(@order)

    render json: { error: 'wrong order params' }
  end

  def update
    authorize authorizable_instance(:update)

    determinant_class = Validations::Determinants::OnOrderDishDeterminant
    updater_service = updater_service_class.new(model: @model,
                                                model_class:,
                                                params: model_params,
                                                on_validation_determinant_class: determinant_class,
                                                params_filter: model_class::ORDER_DISHES_PARAMS)
    render(**updater_service.update)
  end

  def cancel
    Notifications::Orders::Cancellation.new(order: @order, customer: current_user).call

    render json: @order.cancel!
  end

  private

  class << self
    def model_class
      Order
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

  def set_user
    @user = User.find_by(id: params[:user_id])

    update_auth_header
    render json: { error: 'wrong action params' } unless @user
  end  

  def order_params
    params.require(:order).permit(Order::PARAMS)
  end

  def rating_params
    params.permit(Rating::PARAMS)
  end
end
