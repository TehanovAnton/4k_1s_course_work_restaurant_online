# frozen_string_literal:true

module Validations
  module OrderValidation
    module Validators
      class OrderUpdateOnlyEarlierHourBefore < ActiveModel::Validator
        def validate(record)
          @record = record
          @old_record = Order.find_by(id: @record.id)
          return unless @old_record

          record.errors.add(:base, MESSAGE) if update_less_than_hour_before?
        end

        private

        def update_less_than_hour_before?
          (now - start_at) <= 1.hour
        end

        def now
          @now ||= DateTime.now
        end

        def start_at
          @start_at ||= old_record.start_at
        end
      end
    end
  end
end
