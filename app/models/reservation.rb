class Reservation < ApplicationRecord
  PARAMS = [
    :table_id,
    :start_at,
    :end_at,
    :place_type,
    { order_attributes: %i[restaurant_id user_id] }
  ].freeze

  include Validations::Reservation::ReservationValidation

  belongs_to :table, optional: true
  belongs_to :order

  enum place_type: %i[inside outside]

  delegate :admins, to: :order
end
