# frozen_string_literal:true

module Validations
  module Ratings
    module Validators
      class ReferredToFinishedOrderValidator < ActiveModel::Validator
        MESSAGE = 'Only finished order can be rated.'

        def validate(record)
          @record = record

          @record.errors.add(:base, MESSAGE) unless finished_order?
        end

        private

        def rating_order
          OrderState.joins(order: [:rating])
                    .where("ratings.id = #{@record.id}")
                    .select(:aasm_state)
                    .first
        end

        def finished_order?
          rating_order&.finished?
        end
      end
    end
  end
end
