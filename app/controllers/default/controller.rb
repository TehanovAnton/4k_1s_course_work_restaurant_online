# frozen_string_literal: true

module Default
  class Controller < ApplicationController
    before_action :authenticate_user!

    extend ControllerRequiredMethods::ClassMethods
    include ControllerRequiredMethods::InstanceMethods

    def create
      authorize authorizable_instance(:create)

      creater_service = creater_service_class.new(model_class, model_params)
      render(**creater_service.create.response)
    end

    def update
      authorize authorizable_instance(:update)

      updater_service = updater_service_class.new(model_class, model_params)
      render(**updater_service.update(@model))
    end

    def destroy
      authorize authorizable_instance(:destroy)

      destroy_service = destroy_service_class.new
      render(**destroy_service.destroy(@model))
    end

    private

    def updater_service_class
      model_class::MODEL_UPDATER_CLASS
    end

    def creater_service_class
      model_class::MODEL_CREATER_CLASS
    end

    def destroy_service_class
      model_class::MODEL_DESTROYER_CLASS
    end
  end
end
