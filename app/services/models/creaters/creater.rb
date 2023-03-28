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
      attr_reader :params, :model_class, :model, :response

      include CreaterRequiredMethods

      def initialize(model_class, params)
        @params = params
        @model_class = model_class
        @response = {}
      end

      def create
        @model = model_class.new(**params)
        @response =
          if @model.save
            { json: model_serializer.render(@model) }
          else
            { json: @model.errors.messages, status: :unprocessable_entity }
          end
      end

      def model_serializer
        model_class::MODEL_SERIALIZER_CLASS
      end
    end
  end
end
