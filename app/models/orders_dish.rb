class OrdersDish < ApplicationRecord
  include Validations::Order::OrdersDishValidation

  belongs_to :order
  belongs_to :dish
end
