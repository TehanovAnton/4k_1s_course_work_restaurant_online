module Messageble::RestaurantsMessagesApi
  def restaurant_messages
    render json: MessageBlueprint.render(@restaurant.own_messages)
  end

  def post_message
    @restaurant.own_messages << Message.new(message_params)
    ActionCable.server.broadcast('rest_chat_channel', { messages: MessageBlueprint.render(@restaurant.own_messages) })

    render json: ''
  end

  def delete_message
    render json: @restaurant.own_messages.destroy(@message)
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
