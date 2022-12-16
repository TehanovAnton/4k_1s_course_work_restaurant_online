module Messageble::OrdersMessagesApi
  def post_message
    binding.pry
    @order.messages << Message.new(message_params)
    render json: OrderBlueprint.render(@order)
  end

  def delete_message
  end

  private

  def message_params
    params.permit(Message::PARAMS)
  end
end