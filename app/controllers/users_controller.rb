class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: User.find(params[:id])
  end

  def update
    authorize current_user

    return render json: current_user if current_user.update(user_params)

    render json: { error: 'wrong params' }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
