class OrdersDish < ApplicationRecord
  include Validations::OrderValidation::OrdersDishValidation

  belongs_to :order
  belongs_to :dish
end
