module Validations
  module MenuValidation
    module Validators
      class RestaurantMenuNameUniqnessValidator < ActiveModel::Validator
        MESSAGE = 'Menu with the same name already exists in restaurant.'.freeze

        def validate(record)
          @record = record
          find_restaurant_menus_names

          record.errors.add(:base, MESSAGE) if name_already_exists?
        end

        private

        def find_restaurant_menus_names
          @restaurant_menus_names = Menu.joins(:restaurant)
                                        .where(restaurant_id: @record.restaurant_id)
                                        .select(:name)
                                        .pluck(:name)
        end

        def name_already_exists?
          @restaurant_menus_names.include?(@record.name)
        end
      end
    end
  end
end