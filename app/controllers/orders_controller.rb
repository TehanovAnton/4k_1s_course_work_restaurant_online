class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[update destroy show]

  def index
    @orders = current_user.orders

    render json: OrderBlueprint.render(@orders)
  end

  def show
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
    response = { error: 'wrong order params' }

    response = @order if @order.update(order_params)

    render json: response
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
