class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[update destroy create_cook show can_update? can_destroy?]
  before_action :set_authorizer, only: Authorization::RestaurantsAuthorizationApi::ACTIONS

  include Authorization::UsersAuthorizationApi
  include Authorization::UsersResetPasswordApi

  def index
    @users = policy_scope(User)

    render json: UserBlueprint.render(@users)
  end

  def show
    render json: user_json
  end

  def show_by_email
    @user = User.find_by(email: params[:email])
    return wrong_params unless @user

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

    updater = Models::Updaters::UserUpdater.new('User', update_params)
    render(**updater.update(@user, lambda { user_json }))
  end

  def destroy
    authorize User
    response = @user

    response = { error: 'wrong user params' } unless @user.destroy

    render json: response
  end

  private

  def wrong_params
    update_auth_header
    return render(json: { error: 'wrong params' }, status: :unprocessable_entity)
  end

  def user_json
    case @user&.class.name
    when 'Cook'
      UserBlueprint.render(@user, view: :cook)
    when 'Admin'
      UserBlueprint.render(@user, view: :admin)
    when 'SuperAdmin'
      UserBlueprint.render(@user, view: :super_admin)
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
    User::PARAMS
  end
end
