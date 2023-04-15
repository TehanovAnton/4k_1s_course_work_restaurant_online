module Validations
  module DishValidation
    module Validation
      extend ActiveSupport::Concern

      included do
        validates :name, :menu, :price_cents, presence: {
          message: lambda do |_, data|
            "Could not create #{data[:model]} without #{data[:attribute]}"
          end
        }

        validates_with DishValidation::Validators::MenuDishNameUniqnessValidator
      end
    end
  end
end
