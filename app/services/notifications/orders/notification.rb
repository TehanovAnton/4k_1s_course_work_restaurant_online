# frozen_string_literal:true

module Notifications
  module Orders
    class Notification < Notifications::Base
      MAILER = OrderMailer

      private

      def mailer_options
        { user: model.user, order: model }
      end
    end
  end
end
