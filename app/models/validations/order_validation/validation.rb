module Validations
  module OrderValidation
    module Validation
      extend ActiveSupport::Concern

      included do
        validates :user_id, :restaurant_id, presence: true
        validates_with OrderValidation::Validators::OrderUpdateOnlyEarlierHourBefore
      end
    end
  end
end
