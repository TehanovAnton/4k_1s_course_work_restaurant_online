# frozen_string_literal: true

module Models
  module Creaters
    module CreaterRequiredMethods
      def create
        raise NotImplementedError, 'Method should be implemented'
      end

      def model_serializer
        raise NotImplementedError, 'Method should be implemented'
      end
    end

    class Creater
      attr_reader :params, :model_class

      include CreaterRequiredMethods

      def initialize(model_class, params)
        @params = params
        @model_class = model_class
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
