# frozen_string_literal:true

module Cooks
  class OrderPolicy < CookPolicy
    def index?
      cook? && refers_to_order_restaurant?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end

    private

    def record_restaurant
      return unless record.any?

      record.first.restaurant
    end
  end
end
