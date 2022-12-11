class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[update destroy show]

  def index
    @orders = policy_scope(Order)

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

    if @order.update(order_params)
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

  def set_order
    @order = Order.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong order params' } unless @order
  end

  def order_params
    params.require(:order).permit(Order::PARAMS)
  end
end
