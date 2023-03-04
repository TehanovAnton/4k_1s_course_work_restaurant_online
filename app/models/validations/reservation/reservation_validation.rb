module Validations
  module Reservation
    module ReservationValidation
      extend ActiveSupport::Concern

      included do
        validates :table_id, presence: true, if: :inside?

        validates_with Validators::InsideReservationTimeValidator
      end
    end
  end
end
