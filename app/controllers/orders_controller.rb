class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[update destroy show can_update? can_update? can_destroy?]
  before_action :set_user, only: %i[index create can_create?]
  before_action :set_authorizer, only: Authorization::OrdersAuthorizationApi::ACTIONS

  include Authorization::OrdersAuthorizationApi

  def index
    @scope = if current_user.is_a?(SuperAdmin)
      Order.where(user_id: params[:user_id])
    else
      current_user.orders
    end

    @orders = policy_scope(@scope)
    render json: OrderBlueprint.render(@orders)
  end

  def show
    authorize @order

    return render json: OrderBlueprint.render(@order)

    render json: { error: 'wrong order params' }
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      return render json: OrderBlueprint.render(@order)
    end

    render json: { error: @order.errors.full_messages }
  end

  def update
    authorize @order
    if Order.new(order_params).valid?
      @order.dishes.delete_all
      @order.update(order_params)
      return render json: OrderBlueprint.render(@order)
    end

    render json: @order.errors.full_messages
  end

  def destroy
    authorize @order

    response = @order
    response = { error: 'wrong order params' } unless @order.destroy

    render json: response
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])

    update_auth_header
    render json: { error: 'wrong action params' } unless @user
  end

  def set_order
    @order = Order.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong order params' } unless @order
  end

  def order_params
    params.require(:order).permit(Order::PARAMS)
  end
end
