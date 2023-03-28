# frozen_string_literal: true

module Notify
  class Controller < ModelResponse::Controller
    def create
      authorize authorizable_instance(:create)

      creater_service = creater_service_class.new(model_class, model_params)
      notifier_service = notify_service_class.new(creater_service)
      notifier_service.notify
      render(**notifier_service.creater.response)
    end
  end
end
