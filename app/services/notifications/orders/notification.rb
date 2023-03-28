# frozen_string_literal:true

module Notifications
  module Orders
    class Notification
      attr_reader :order_mailer_class, :creater

      MAILER = OrderMailer

      def initialize(creater)
        @creater = creater
      end

      def notify
        @creater_response = creater.create
        MAILER.with(user: creater.model.user, order: creater.model)
              .order_created
              .deliver_later
      end
    end
  end
end
