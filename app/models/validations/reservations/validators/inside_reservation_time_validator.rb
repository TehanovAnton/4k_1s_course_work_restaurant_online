# frozen_string_literal:true

module Validations
  module Reservations
    module Validators
      class InsideReservationTimeValidator < ActiveModel::Validator
        attr_reader :record, :start_at, :end_at, :table

        def validate(record)
          return unless record.inside? &&
                        record.table &&
                        record.start_at &&
                        record.end_at

          @record = record
          @start_at = record.start_at
          @end_at = record.end_at
          @table = record.table.reload

          start_earlier_than_end?
          start_earlier_than_now?
          time_not_in_other_reservation?(start_at)
          time_not_in_other_reservation?(end_at)
          time_not_cover_other_reservation?
        end

        def start_earlier_than_now?
          condition = start_at > Time.now
          record.errors.add :base, "Reservation start time can't be earlier than now." unless condition
        end

        def start_earlier_than_end?
          condition = start_at < end_at
          record.errors.add :base, "Reservation start time can't be earlier than end." unless condition
        end

        def time_not_in_other_reservation?(time)
          condition = table.reservations.none? do |reservation|
            reservation.id != record.id &&
              time.between?(reservation.start_at, reservation.end_at)
          end

          record.errors.add :base, 'It seems there is another reservation at that time' unless condition
        end

        def time_not_cover_other_reservation?
          condition = table.reservations.none? do |reservation|
            reservation.id != record.id &&
              (between?(record.start_at, reservation.start_at, reservation.end_at) ||
              between?(record.end_at, reservation.start_at, reservation.end_at))
          end

          record.errors.add :base, 'It seems your time covers other reservations' unless condition
        end

        private

        def between?(time, start_at, end_at)
          time.between?(start_at, end_at)
        end
      end
    end
  end
end
