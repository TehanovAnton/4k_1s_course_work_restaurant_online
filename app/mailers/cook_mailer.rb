class CookMailer < ApplicationMailer
  def account_created
    @cook = params[:user]
    return unless @cook.user

    @url = user_send_reset_password_url
    mail(to: @cook.user.email, subject: 'Working account created.')
  end

  private

  def user_send_reset_password_url
    Rails.application.routes.url_helpers.send_reset_password_users_url(reset_password: { email: @cook.user.email }, host: 'localhost:3000')
  end
end