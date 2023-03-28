# frozen_string_literal:true

module Validations
  module Reservations
    module Validation
      extend ActiveSupport::Concern

      included do
        validates :table_id, presence: true, if: :inside?

        validates_with Validators::InsideReservationTimeValidator
      end
    end
  end
end
