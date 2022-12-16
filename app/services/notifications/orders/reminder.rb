module Notifications
  module Orders
    class Reminder < Notifications::Orders::Base
      def call
        super()

        OrderNotificationsMailer.with(customer: @customer, order: @order).reminder.deliver_later
      end
    end
  end
end
