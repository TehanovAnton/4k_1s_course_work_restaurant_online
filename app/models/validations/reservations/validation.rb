# frozen_string_literal:true

module Validations
  module Reservations
    module Validation
      extend ActiveSupport::Concern

      included do
        validates :start_at, presence: true

        with_options if: :inside? do |order|
          order.validates :end_at, presence: true

          order.validates_presence_of :table, message: proc {
            "Could not create reservation without table."
          }
        end

        validates_with Validators::InsideReservationTimeValidator
      end
    end
  end
end
