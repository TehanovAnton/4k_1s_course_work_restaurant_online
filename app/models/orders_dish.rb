class OrdersDish < ApplicationRecord
  include Validations::Orders::OrdersDishValidation

  belongs_to :order
  belongs_to :dish
end
