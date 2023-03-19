
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

      validates :email, format: Devise.email_regexp
    end
  end
end
