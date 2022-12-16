module Notifications
  module Orders
    class Cancellation < Notifications::Orders::Base
      def call
        super()

        OrderNotificationsMailer.with(customer: @customer, order: @order).cancelled.deliver_later
      end
    end
  end
end
