# frozen_string_literal: true

module Authorization
  module UsersResetPasswordApi
    extend ActiveSupport::Concern

    included do
      skip_before_action :authenticate_user!, only: %i[reset_password]
      before_action :set_reset_password_user, only: %i[reset_password]


      def reset_password        
        return wrong_params if reset_passwords.values.reduce { |param| param.nil? || param.empty? }
        
        return wrong_params unless @reset_password_user.reset_password(reset_passwords[:password], reset_passwords[:password_confirmation])

        render plain: :ok
      rescue StandardError => e
        return wrong_params
      end

      private

      def wrong_params
        update_auth_header
        return render(json: { error: 'wrong params' }, status: :unprocessable_entity)
      end

      def set_reset_password_user
        @reset_password_user = User.find_by(email: reset_password_params[:email])

        wrong_params unless @reset_password_user
      rescue StandardError => e
        return wrong_params
      end

      def reset_password_params
        permit_params = [:email, passwords: %i[password password_confirmation]]
        params.require(:reset_password).permit(permit_params)
      end

      def reset_passwords
        reset_password_params[:passwords]
      end
    end
  end
end
