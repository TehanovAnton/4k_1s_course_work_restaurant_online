class Reservation < ApplicationRecord
  belongs_to :table
  belongs_to :order
end
