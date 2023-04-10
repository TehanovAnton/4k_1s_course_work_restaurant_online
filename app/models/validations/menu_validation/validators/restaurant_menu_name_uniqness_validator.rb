module Validations
  module MenuValidation
    module Validators
      class RestaurantMenuNameUniqnessValidator < Validations::Validators::NameUniqnessValidator
        private

        class << self
          def validator_message
            'Menu with the same name already exists in restaurant.'
          end
        end

        def find_names
          @names = Menu.joins(:restaurant)
                       .where(restaurant_id: @record.restaurant_id)
                       .select(:name)
                       .pluck(:name)
        end
      end
    end
  end
end
