
module Authorization::MenusAuthorizationApi
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
    auth_obj = @restaurant
    auth_obj = @menu if params[:id]

    @authorizer = MenuPolicy.new(current_user, auth_obj)
  end
end
