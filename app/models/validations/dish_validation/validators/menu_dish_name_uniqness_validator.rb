module Validations
  module DishValidation
    module Validators
      class MenuDishNameUniqnessValidator < Validations::Validators::NameUniqnessValidator
        private

        class << self
          def validator_message
            'Dish with the same name already exists in menu.'
          end
        end

        def find_names
          @names = Dish.joins(:menu)
                       .where(menu_id: @record.menu_id)
                       .select(:id, :name)
                       .pluck(:id, :name)
        end
      end
    end
  end
end
