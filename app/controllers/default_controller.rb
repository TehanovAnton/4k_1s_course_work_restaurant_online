class DefaultController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize authorizable_instance(:create)

    creater_service = creater_service_class.new(menu_params)
    render(**creater_service.create)
  end

  private

  def creater_service_class
    Models::Creaters::Creater
  end

  def authorizable_instance(action)
    rais NotImplementedError, 'Action should have authorizable_instance method'
  end
end
