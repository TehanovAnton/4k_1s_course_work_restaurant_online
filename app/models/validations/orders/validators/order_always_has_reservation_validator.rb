# frozen_string_literal:true

module Validations
  module Orders
    module Validators
      class OrderAlwaysHasReservationValidator < ActiveModel::Validator
        MESSAGE = 'Order must has reservation'

        def validate(record)
          @record = record
          record.errors.add(:base, MESSAGE) unless reservation?
        end

        private

        def reservation?
          return false unless @record.reservation

          true
        end
      end
    end
  end
end
