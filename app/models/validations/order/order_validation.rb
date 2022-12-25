module Validations
  module Order
    module OrderValidation
      extend ActiveSupport::Concern

      included do
        validates :user_id, :restaurant_id, presence: true
      end
    end
  end
end
