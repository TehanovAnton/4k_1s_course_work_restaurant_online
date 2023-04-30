class CompaniesRestaurant < ApplicationRecord
  belongs_to :restaurant, optional: true
  belongs_to :company, optional: true

  validates_presence_of :company, message: proc {
    "is missing"
  }
end
