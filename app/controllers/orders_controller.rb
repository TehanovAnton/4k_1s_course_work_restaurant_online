class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[update destroy show can_update? can_update? can_destroy? cancel post_rating
                                     destroy_rating post_message delete_message order_messages]
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

  def create
    @order = Order.new(order_params)

    @order.messages << Message.new(message_params) 
    if @order.save
      Notifications::Orders::Confirmation.new(order: @order, customer: current_user).call

      Notifications::Orders::ReminderWorker.perform_at(@order.reservations.first.start_at - 1.day, @order.id)
      Notifications::Orders::ReminderWorker.perform_at(@order.reservations.first.start_at - 12.hours, @order.id)
      Notifications::Orders::ReminderWorker.perform_at(@order.reservations.first.start_at - 1.hour, @order.id)

      return render json: OrderBlueprint.render(@order)
    end

    render json: { error: @order.errors.full_messages }
  end

  def update
    authorize @order

    if Order.new(order_params).valid?
      @order.dishes.delete_all
      @order.reservations.delete_all

      @order.update(order_params)
      return render json: OrderBlueprint.render(@order)
    end

    render json: @order.errors.full_messages
  end

  def post_rating
    @order.rating = Rating.new(rating_params)

    render json: @order.rating
  end

  def destroy_rating
    render json: @order.rating.destroy
  end

  def destroy
    authorize @order

    response = @order

    Notifications::Orders::Cancellation.new(order: @order, customer: current_user).call

    response = { error: 'wrong order params' } unless @order.destroy

    render json: response
  end

  def cancel
    Notifications::Orders::Cancellation.new(order: @order, customer: current_user).call

    render json: @order.cancel!
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

  def rating_params
    params.permit(Rating::PARAMS)
  end
end
