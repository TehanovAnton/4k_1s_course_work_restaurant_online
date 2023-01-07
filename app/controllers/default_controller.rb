class DefaultController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize Menu

    creater = Models::Creaters::MenuCreater.new(menu_params)
    render(**creater.create)
  end
end
