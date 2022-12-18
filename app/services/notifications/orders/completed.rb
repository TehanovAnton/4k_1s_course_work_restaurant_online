module Notifications
  module Orders
    class Completed < Notifications::Orders::Base
      def call
        super()

        OrderNotificationsMailer.with(customer: @customer, order: @order).completed.deliver_later
      end
    end
  end
end
