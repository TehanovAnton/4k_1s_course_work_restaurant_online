module Validations
  module MenuValidation
    module Validation
      extend ActiveSupport::Concern

      included do
        validates :name, :restaurant, presence: {
          message: lambda do |_, data|
            "Could not create #{data[:model]} without #{data[:attribute]}"
          end
        }

        validates_with MenuValidation::Validators::RestaurantMenuNameUniqnessValidator
      end
    end
  end
end
