module Notifications
  module Orders
    class Base
      class NilOrderError < StandardError
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

      def initialize(order:, customer:)
        @order = order
        @customer = customer
      end

      def call
        raise NilOrderError unless @order
        raise NilCustomerError unless @customer
      end
    end
  end
end
