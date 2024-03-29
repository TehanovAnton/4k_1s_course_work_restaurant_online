# frozen_string_literal: true

module Models
  module Updaters
    module UpdaterRequiredMethods
      def update
        raise NotImplementedError, 'Method should be implemented'
      end

      def model_serializer
        raise NotImplementedError, 'Method should be implemented'
      end
    end

    class Updater
      attr_reader :params, :model_class

      include UpdaterRequiredMethods

      def initialize(model_class, params)
        @params = params
        @model_class = model_class
      end

      def update(model)
        return { json: model.errors.messages, status: :bad_request } unless model.update(**params)

        { json: model_serializer.render(model) }
      end

      def model_serializer
        model_class::MODEL_SERIALIZER_CLASS
      end
    end
  end
end
