class DefaultController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize Menu

    creater_service = creater_service_class.new(menu_params)
    render(**creater_service.create)
  end

  private

  def creater_service_class
    Models::Creaters::Creater
  end
end
