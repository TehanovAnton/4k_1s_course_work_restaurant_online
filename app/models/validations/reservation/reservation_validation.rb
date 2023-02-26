
module Validations
  module Reservation
    module ReservationValidation
      extend ActiveSupport::Concern

      included do
        validates :order_id, presence: true
        validates :table_id, presence: true, if: :inside?

        validates_with Validators::InsideReservationTimeValidator
      end
    end
  end
end
