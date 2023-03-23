# frozen_string_literal:true

module Validations
  module Determinants
    module DeterminantRequiredMethods
      def on
        raise NotImplementedError, 'Method should be implemented'
      end

      def on?
        raise NotImplementedError, 'Method should be implemented'
      end
    end

    class OnOrderDishDeterminant
      include DeterminantRequiredMethods

      def initialize(params, params_filter)
        @params = params
        @params_filter = params_filter
      end

      def on
        :on_dishes_update
      end

      def on?
        @params.keys.map(&:to_sym) == @params_filter.keys
      end
    end
  end
end
