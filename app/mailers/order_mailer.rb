# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'tehanovanton@gmail.com'

  def order_created
    @user = params[:user]
    @order = params[:order]
    @url = 'http://localhost:5173/sign_in'
    return unless @order

    mail(to: @user.email, subject: 'Thank you for order.')
  end

  def order_remind
    @user = params[:user]
    @order = params[:order]
    @url = 'http://localhost:5173/sign_in'
    return unless @order

    mail(to: @user.email, subject: 'Thank you for order.')
  end
end
