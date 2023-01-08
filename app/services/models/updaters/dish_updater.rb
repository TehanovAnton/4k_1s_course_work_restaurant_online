# frozen_string_literal: true

module Models
  module Updaters
    class DishUpdater < Updater
      def model_class
        Dish
      end
    end
  end
end
