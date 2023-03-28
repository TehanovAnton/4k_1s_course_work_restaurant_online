# frozen_string_literal:true

class Reservation < ApplicationRecord
  PARAMS = [
    :table_id,
    :start_at,
    :end_at,
    :place_type
  ].freeze

  include Validations::Reservations::Validation

  belongs_to :table, optional: true
  belongs_to :order

  enum place_type: %i[inside outside]

  delegate :admins, to: :order
end
