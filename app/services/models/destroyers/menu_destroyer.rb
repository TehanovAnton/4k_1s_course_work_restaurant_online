# frozen_string_literal: true

module Models
  module Destroyers
    class MenuDestroyer < Destroyer
      def model_class
        Menu
      end

      def model_serializer
        MenuBlueprint
      end
    end
  end
end
