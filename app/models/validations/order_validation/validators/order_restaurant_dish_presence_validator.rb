module Validations
  module OrderValidation
    module Validators
      class OrderRestaurantDishPresenceValidator < ActiveModel::Validator
        MESSAGE = 'Dish is not found in order restaurant'.freeze

        def validate(record)
          order_restaurant = record.order.restaurant
          record.errors.add(:base, MESSAGE) unless order_restaurant.dishes.include?(record.dish)
        end
      end
    end
  end
end
