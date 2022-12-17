module Messageble::OrdersMessagesApi
  def order_messages
    authorize @order

    render json: MessageBlueprint.render(@order.messages)
  end

  def post_message
    authorize Order

    @order.messages << Message.new(message_params)
    render json: MessageBlueprint.render(@order.messages)
  end

  def delete_message
    authorize @order

    render json: @order.messages.destroy(@message)
  end

  private

  def set_message
    @message = Message.find_by(id: params[:message_id])

    update_auth_header
    render json: { error: 'wrong action params' } unless @message
  end

  def message_params
    params.permit(Message::PARAMS)
  end
end
