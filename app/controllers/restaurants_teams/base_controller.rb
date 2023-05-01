# frozen_string_literal:true

module RestaurantsTeams
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :set_model

    include Default::ControllerRequiredMethods::InstanceMethods
    extend Default::ControllerRequiredMethods::ClassMethods

    def create_cook
      authorize authorizable_instance(:create_cook), policy_class: RestaurantPolicy     
    end
    
    def team
      authorize authorizable_instance(:team), policy_class: RestaurantPolicy     
    end

    class << self
      def model_class
        Restaurant
      end
    end    

    private

    def wrong_params(message: 'wrong params')
      update_auth_header
      return render(json: { error: message }, status: :unprocessable_entity)
    end

    def authorizable_instance(action)
      case action
      when :team, :create_cook
        @model
      end
    end
  end
end
