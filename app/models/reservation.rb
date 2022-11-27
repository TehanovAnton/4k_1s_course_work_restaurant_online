class Reservation < ApplicationRecord
  belongs_to :table
  belongs_to :order

  accepts_nested_attributes_for :order
  
  delegate :admins, to: :order
end
