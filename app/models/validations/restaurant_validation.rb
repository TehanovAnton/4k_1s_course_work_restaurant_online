
module Validations
  module RestaurantValidation
    extend ActiveSupport::Concern

    included do
      validates :name, :email, :address, presence: {
        message: lambda do |_, data|
          "Could not create #{data[:model]} without #{data[:attribute]}"
        end
      }
      validates :email, format: Devise.email_regexp
    end
  end
end
