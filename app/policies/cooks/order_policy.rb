# frozen_string_literal:true

module Cooks
  class OrderPolicy < ReferrersPolicy
    REFERRED_MODEL = Restaurant

    def index?
      cook? && referres_to_reffered_model?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end

    private

    def reffered_record
      return unless record.any?

      record.first.restaurant
    end

    def user_referred_filter
      { id: user.restaurant.id }
    end
  end
end
