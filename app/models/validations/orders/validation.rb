# frozen_string_literal:true

module Validations
  module Orders
    module Validation
      extend ActiveSupport::Concern

      included do
        validates :user_id, :restaurant_id, presence: true
        validates_with Orders::Validators::OrderUpdateOnlyEarlierHourBefore, on: :on_dishes_update
        validates_with Orders::Validators::OrderAlwaysHasReservationValidator
      end
    end
  end
end
