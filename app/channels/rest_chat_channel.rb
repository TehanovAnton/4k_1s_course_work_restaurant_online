class RestChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'rest_chat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
