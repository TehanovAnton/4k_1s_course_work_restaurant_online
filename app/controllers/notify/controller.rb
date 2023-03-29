# frozen_string_literal: true

module Notify
  class Controller < ModelResponse::Controller
    def create
      authorize authorizable_instance(:create)

      creater_service = creater_service_class.new(model_class, model_params)
      @model = creater_service.create.model
      notify_after_create
      render(**creater_service.response)
    end

    private

    def notify_after_create
      raise NotImplementedError, "'notify' method is not implemented"
    end

    def notify_service_class
      model_class::NOTIFIER_CLASS
    end
  end
end
