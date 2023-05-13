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

        validates :name, length: {
          within: (2..255),
          message: "Wrong name length."
        }

        validates_with MenuValidation::Validators::RestaurantMenuNameUniqnessValidator
      end
    end
  end
end
