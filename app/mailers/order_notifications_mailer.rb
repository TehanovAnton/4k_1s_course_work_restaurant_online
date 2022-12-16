class OrderNotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifications_mailer.confirmed.subject
  #
  def confirmed
    @message = "Order #{params[:order].id} confirmed"

    mail to: params[:customer].email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifications_mailer.cancelled.subject
  #
  def cancelled
    @message = "Order #{params[:order].id} cancelled"

    mail to: params[:customer].email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifications_mailer.completed.subject
  #
  def completed
    @message = "Order #{params[:order].id} completed"

    mail to: params[:customer].email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifications_mailer.reminder.subject
  #
  def reminder
    @message = "Reminder about Order #{params[:order].id}"

    mail to: params[:customer].email
  end
end
