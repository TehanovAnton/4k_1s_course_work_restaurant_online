# frozen_string_literal: true

module Models
  module Attachers
    module AttacherRequiredMethods
      def attach
        raise NotImplementedError, 'Method should be implemented'
      end

      def model_serializer
        raise NotImplementedError, 'Method should be implemented'
      end
    end

    class Attacher
      attr_reader :model

      include AttacherRequiredMethods

      def initialize(model, image)
        @model = model
        @image = image
      end

      def attach
        @model.image.attach(@image)

        { json: model_serializer.render(@model) }
      end

      private

      def model_serializer
        model.class::MODEL_SERIALIZER_CLASS
      end
    end
  end
end
