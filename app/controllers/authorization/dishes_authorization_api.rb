
module Authorization::DishesAuthorizationApi
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
    auth_obj = @menu
    auth_obj = @dish if params[:id]

    @authorizer = DishPolicy.new(current_user, auth_obj)
  end
end
