class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[update destroy show can_update? can_destroy?]
  before_action :set_authorizer, only: Authorization::RestaurantsAuthorizationApi::ACTIONS

  include Authorization::UsersAuthorizationApi

  def index
    @users = policy_scope(User)

    render json: UserBlueprint.render(@users)
  end

  def show
    render json: user_json
  end

  def show_by_email
    @user = User.find_by(email: params[:email])

    render json: user_json

    update_auth_header
    return render json: { error: 'wrong user params' } unless @user
  end

  def create
    authorize User

    @user = User.create(user_params)
    return render json: @user if @user.valid?

    render json: { error: 'wrong user params' }
  end

  def update
    authorize @user, policy_class: UserPolicy

    @user = User.find(@user.id) if @user.update(update_params)
    @user.update(update_cooks_params) unless update_cooks_params.empty?

    unless update_admin_params.empty?
      @user.update(update_admin_params)
    end

    render json: user_json
  end

  def destroy
    authorize User
    response = @user

    response = { error: 'wrong user params' } unless @user.destroy

    render json: response
  end

  private

  def user_json
    case @user&.class.name
    when 'Cook'
      UserBlueprint.render(@user, view: :cook)
    when 'SuperAdmin', 'Admin'
      UserBlueprint.render(@user, view: :admin)
    else
      UserBlueprint.render(@user)
    end
  end

  def set_user
    @user = User.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong user params' } unless @user
  end

  def update_params
    params.require(:user).permit(:name, :email, :type)
  end

  def update_cooks_params
    params.require(:user).permit(restaurants_cook_attributes: [:id, :restaurant_id])
  end

  def update_admin_params
    params.require(:user).permit(restaurants_admins_attributes: [:id, :restaurant_id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :type)
  end
end
