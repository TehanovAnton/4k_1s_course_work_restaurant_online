module Validations
  module Menu
    module MenuValidation
      extend ActiveSupport::Concern

      included do
        validates :name, :restaurant, presence: {
          message: lambda do |_, data|
            "Could not create #{data[:model]} without #{data[:attribute]}"
          end
        }
      end
    end
  end
end
