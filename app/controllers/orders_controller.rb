class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[update destroy show]

  def index
    @orders = current_user.orders

    render json: OrderBlueprint.render(@orders)
  end

  def show
    return render json: @order

    render json: { error: 'wrong order params' }
  end

  def create
    return render json: Order.create(order_params)

    render json: { error: 'wrong order params' }
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
      orders_dishes_attributes: [:id, :dish_id],
      reservations_attributes: [:id, :table_id]
    ]

    params.require(:order).permit(order_params)
  end
end
