
module Validations
  module RestaurantValidation
    extend ActiveSupport::Concern

    included do
      validates :name, :email, :address, presence: {
        message: lambda do |_, data|
          "Could not create #{data[:model]} without #{data[:attribute]}"
        end
      }

      validates :name, :email, uniqueness: {
        case_sensitive: false,
        message: lambda do |_, data|
          "Restaurant with the same #{data[:attribute]} already exists."
        end
      }

      validates :email, format: {
        with: Devise.email_regexp,
        message: "Email has incorret format."
      }

      validates_presence_of :companies_restaurant, message: proc {
        "Company is missing."
      }
    end
  end
end
