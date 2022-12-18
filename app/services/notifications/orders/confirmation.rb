module Notifications
  module Orders
    class Confirmation < Notifications::Orders::Base
      def call
        super()

        OrderNotificationsMailer.with(customer: @customer, order: @order).confirmed.deliver_later
      end
    end
  end
end
