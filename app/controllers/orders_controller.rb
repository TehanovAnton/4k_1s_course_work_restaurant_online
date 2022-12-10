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
    order_params = [
      :user_id,
      :restaurant_id,
      :place_type,
      { orders_dishes_attributes: %i[id dish_id] },
      { reservations_attributes: %i[id table_id start_at end_at] }
    ]

    params.require(:order).permit(order_params)
  end
end
