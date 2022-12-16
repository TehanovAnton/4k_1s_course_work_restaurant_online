module Notifications
  module Orders
    class BaseWorker
      include Sidekiq::Worker

      class NilOrderError
      include Sidekiq::Worker
        MESSAGE = "Order can't be nil"

        def message
          MESSAGE
        end
      end

      class NilCustomerError < StandardError
        MESSAGE = "Customer can't be nil"

        def message
          MESSAGE
        end
      end

      def perform(order_id)
        @order = Order.find_by id: order_id
        raise NilOrderError unless @order

        @customer = @order.user
        raise NilCustomerError unless @customer
      end
    end
  end
end

