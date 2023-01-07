# frozen_string_literal: true

module Models
  module Creaters
    module CreaterRequiredMethods
      def create
        raise NotImplementedError, 'Method should be implemented'
      end

      def model_class
        raise NotImplementedError, 'Method should be implemented'
      end

      def model_serializer
        raise NotImplementedError, 'Method should be implemented'
      end
    end

    class Creater
      attr_reader :params

      include CreaterRequiredMethods

      def initialize(params)
        @params = params
      end

      def create
        @model = model_class.new(**params)

        return { json: @model.errors.messages, status: :unprocessable_entity } unless @model.save

        { json: model_serializer.render(@model) }
      end

      def model_serializer
        model_class::MODEL_SERIALIZER_CLASS
      end
    end
  end
end
