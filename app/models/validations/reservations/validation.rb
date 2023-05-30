# frozen_string_literal:true

module Validations
  module Reservations
    module Validation
      extend ActiveSupport::Concern

      included do
        validates :start_at, presence: {
          message: 'Could not create order withou start time.'
        }

        validate :start_at_greater_than_now

        with_options if: :inside? do |order|
          order.validates :end_at, presence: true

          order.validates_presence_of :table, message: proc {
            "Could not create reservation without table."
          }
        end

        validates_with Validators::InsideReservationTimeValidator

        private

        def start_at_greater_than_now
          errors.add(:start_at, "wrong start time") if start_at < DateTime.now
        end
      end
    end
  end
end
