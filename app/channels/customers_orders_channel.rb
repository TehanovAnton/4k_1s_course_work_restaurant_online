class CustomersOrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'customers_orders_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
