module Messageble::OrdersMessagesApi  

  def post_message
    @order.messages << Message.new(message_params)
    render json: MessageBlueprint.render(@order.messages.last)
  end

  def delete_message
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
