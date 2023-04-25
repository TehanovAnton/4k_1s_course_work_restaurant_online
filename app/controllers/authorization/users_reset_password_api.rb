# frozen_string_literal: true

module Authorization
  module UsersResetPasswordApi
    extend ActiveSupport::Concern

    included do
      skip_before_action :authenticate_user!, only: %i[send_reset_password]
      before_action :set_reset_password_user, only: %i[send_reset_password]

      def send_reset_password
        @reset_password_user.send_reset_password_instructions

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
        permit_params = [:email]
        params.require(:reset_password).permit(permit_params)
      end
    end
  end
end
