# frozen_string_literal: true

module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    private

    def sign_up_params
      params.permit(:name, :email, :password, :password_confirmation, :type, restaurants_cook_attributes: [:restaurant_id])
    end
  end
end
