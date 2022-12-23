module Validations
  module OrderValidation
    validates :user_id, :restaurant_id, presence: true
  end
end
