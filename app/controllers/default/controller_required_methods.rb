# frozen_string_literal: true

module Default
  module ControllerRequiredMethods
    module InstanceMethods
      def authorizable_instance(_action)
        rais NotImplementedError, 'Model controller should provide authorizable_instance method'
      end

      def model_class
        self.class.model_class
      end

      def model_params
        params.require(model_scope).permit(model_class::PARAMS)
      end

      def model_scope
        model_class.name.downcase.to_sym
      end

      def set_model
        @model = model_class.find_by(id: params[:id])

        update_auth_header
        render(json: { error: 'wrong menu params' }, status: :unprocessable_entity) unless @model
      end
    end

    module ClassMethods
      def model_class
        raise NotImplementedError, 'Model controller should provide model class'
      end
    end
  end
end
