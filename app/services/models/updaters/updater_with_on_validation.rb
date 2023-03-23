# frozen_string_literal:true

module Models
  module Updaters
    class UpdaterWithOnValidation < Updater
      attr_reader :model, :on_validation_determinant

      def initialize(model:, model_class:, params:, on_validation_determinant_class:, params_filter:)
        super(model_class, params)

        @model = model
        @on_validation_determinant = on_validation_determinant_class.new(params, params_filter)
      end

      def update
        return { json: model.errors.messages, status: :bad_request } unless valid? || model.update(**params)

        { json: model_serializer.render(model) }
      end

      private

      def valid?
        model.assign_attributes(params)
        return model.valid?(on_validation_determinant.on) if on_validation_determinant.on?

        model.valid?
      end
    end
  end
end
