# frozen_string_literal: true

module Cooks
  class OrderStatesController < ApplicationController
    include DefaultController::RequeredMethods::InstanceMethods
    extend DefaultController::RequeredMethods::ClassMethods

    before_action :authenticate_user!
    before_action :set_model, :set_transition_name

    def transition
      authorize [:cooks, authorizable_instance(:transition)]

      transitor = transition_servive_class.new(@model, @transition_name)
      render(**transitor.transit)
    end

    private

    class << self
      def model_class
        OrderState
      end
    end

    def set_transition_name
      @transition_name = params[:transition]
    end

    def authorizable_instance(_action)
      @model
    end

    def transition_servive_class
      model_class::TRANSITION_SERVICE_CLASS
    end
  end
end
