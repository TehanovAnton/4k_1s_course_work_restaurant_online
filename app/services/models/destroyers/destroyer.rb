# frozen_string_literal: true

module Models
  module Destroyers
    module DestroyerRequiredMethods
      def destroy
        raise NotImplementedError, 'Method should be implemented'
      end

      def model_class
        raise NotImplementedError, 'Method should be implemented'
      end

      def model_serializer
        raise NotImplementedError, 'Method should be implemented'
      end
    end

    class Destroyer
      attr_reader :params

      include DestroyerRequiredMethods

      def destroy(model)
        return { json: model.errors.messages, status: :unprocessable_entity } unless model.destroy

        { plain: :ok }
      end
    end
  end
end
