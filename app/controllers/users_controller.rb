class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[update destroy show]

  def show    
    return render json: @user

    render json: { error: 'wrong user params' }
  end

  def create
    authorize User

    @user = User.create(user_params)
    return render json: @user if @user.valid?

    render json: { error: 'wrong user params' }
  end

  def update
    authorize User
    response = { error: 'wrong user params' }

    response = @user if @user.update(user_params)

    render json: response
  end

  def destroy
    authorize User
    response = @user

    response = { error: 'wrong user params' } unless @user.destroy

    render json: response
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong user params' } unless @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :type)
  end
end
