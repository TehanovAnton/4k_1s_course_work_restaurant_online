module Validations
  module Orders
    module OrdersDishValidation
      extend ActiveSupport::Concern

      included do
        validates :dish_id, presence: true

        validates_with Orders::Validators::OrderRestaurantDishPresenceValidator
      end
    end
  end
end
