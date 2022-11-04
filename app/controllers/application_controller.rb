class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up_params, keys: %i[name email])
  # end
end
