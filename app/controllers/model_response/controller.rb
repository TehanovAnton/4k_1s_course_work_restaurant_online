# frozen_string_literal: true

module ModelResponse
  class Controller < Default::Controller
    def destroy
      authorize authorizable_instance(:destroy)

      destroy_service = destroy_service_class.new(@model)
      render(**destroy_service.destroy)
    end
  end
end
