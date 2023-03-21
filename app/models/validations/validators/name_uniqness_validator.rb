module Validations
  module Validators
    module NameUniqnessValidatorRequiredMethods
      private

      def find_restaurant_menus_names
        raise NotImplementedError, 'Method should be implemented'
      end

      def name_already_exists?
        raise NotImplementedError, 'Method should be implemented'
      end
    end

    class NameUniqnessValidator < ActiveModel::Validator
      include NameUniqnessValidatorRequiredMethods

      MESSAGE = 'Menu with the same name already exists in restaurant.'.freeze

      def validate(record)
        @record = record
        find_names

        record.errors.add(:base, validator_message) if name_already_exists?
      end

      private

      class << self
        def validator_message
          raise NotImplementedError, 'Validator should provide MESSAGE'
        end
      end

      def find_names
        raise NotImplementedError, 'Define @names'
      end

      def name_already_exists?
        !@names.select do |id, name|
          name == @record.name && @record.id != id
        end.empty?
      end

      def validator_message
        self.class.validator_message
      end
    end
  end
end
