module Models
  module Destroyers
    module ModelResponse
      module DestroyerRequiredMethods
        def model_class
          @model_class ||= model.class
        end

        def model_serializer
          @model_serializer ||= model_class::MODEL_SERIALIZER_CLASS
        end
      end

      class Destroyer < Destroyers::Destroyer
        attr_reader :model, :model_json

        include DestroyerRequiredMethods

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
      end
    end
  end
end
