
module Validations
  module RestaurantValidation
    extend ActiveSupport::Concern

    included do
      validates :name, :email, :address, presence: true
      validates :email, format: Devise.email_regexp
    end
  end
end
