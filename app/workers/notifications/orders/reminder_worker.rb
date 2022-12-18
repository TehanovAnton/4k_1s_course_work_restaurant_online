module Notifications
  module Orders
    class ReminderWorker < Notifications::Orders::BaseWorker
      def perform(order_id)
        super

        OrderNotificationsMailer.with(order: @order, customer: @customer).reminder.deliver_later
      end
    end
  end
end
