module Validations
  module OrderValidation
    module OrdersDishValidation
      extend ActiveSupport::Concern

      included do
        validates :dish_id, presence: true

        validates_with Order::Validators::OrderRestaurantDishPresenceValidator
      end
    end
  end
end
