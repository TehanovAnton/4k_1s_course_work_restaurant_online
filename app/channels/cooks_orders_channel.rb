class CooksOrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'cooks_orders_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
