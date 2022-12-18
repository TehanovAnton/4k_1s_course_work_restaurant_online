class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_channel'
    ChatChannel.send_message
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.send_message
    ActionCable.server.broadcast('chat_channel', { body: 'hello client' })
  end
end
