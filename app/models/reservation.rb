class Reservation < ApplicationRecord
  PARAMS = [
    :table_id,
    :start_at,
    :end_at,
    :place_type,
    { order_attributes: %i[restaurant_id user_id] }
  ]

  belongs_to :table, optional: true
  belongs_to :order

  enum place_type: %i[inside outside]

  accepts_nested_attributes_for :order

  delegate :admins, to: :order
end
