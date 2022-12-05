
module Authorization::UsersAuthorizationApi
  ACTIONS = %i[can_create? can_update? can_destroy?]

  def can_create?
    render json: @authorizer.create?
  end

  def can_update?
    render json: @authorizer.update?
  end

  def can_destroy?
    render json: @authorizer.destroy?
  end

  private

  def set_authorizer
    auth_obj = User
    auth_obj = @user if params[:id]

    @authorizer = UserPolicy.new(current_user, auth_obj)
  end
end
