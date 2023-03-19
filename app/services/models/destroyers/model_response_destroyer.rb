module Models
  module Destroyers
    module ModelResponseDestroyerMethods
      def model_class
        raise NotImplementedError, 'Method should be implemented'
      end

      def model_serializer
        raise NotImplementedError, 'Method should be implemented'
      end
    end

    class ModelResponseDestroyer < Destroyer
      attr_reader :model, :model_json

      include ModelResponseDestroyerMethods

      def initialize(model)
        super()

        @model = model
        @model_json = model_serializer.render(@model)
      end

      def destroy
        model.destroy
        { json: model_json }
      rescue StandardError
        { json: model.errors.messages, status: :unprocessable_entity }
      end

      private

      def model_class
        @model_class ||= model.class
      end

      def model_serializer
        @model_serializer ||= model_class::MODEL_SERIALIZER_CLASS
      end
    end
  end
end
