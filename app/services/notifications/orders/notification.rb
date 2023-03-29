# frozen_string_literal:true

module Notifications
  module Orders
    class Notification
      attr_reader :order

      MAILER = OrderMailer

      def initialize(order)
        @order = order
      end

      def notify
        MAILER.with(user: order.user, order:)
              .order_created
              .deliver_later
      end
    end
  end
end
