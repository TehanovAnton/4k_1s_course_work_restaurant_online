class UsersController < ApplicationController
  def show
    render json: User.find(params[:id])
  end

  def create
    binding.pry
    render json: User.create(user_params)
  end

  def edit
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
