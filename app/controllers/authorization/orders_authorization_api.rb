module Authorization::OrdersAuthorizationApi
  ACTIONS = %i[can_update? can_destroy? can_create?]
  MODEL_AUTH_ACTIONS = %i[can_update? can_destroy?].freeze
  MODEL_AUTH_CREATE_ACTION = %i[can_create?].freeze

  def can_update?
    render json: @authorizer.update?
  end

  def can_destroy?
    render json: @authorizer.destroy?
  end

  def can_create?
    render json: @authorizer.create?
  end

  private

  def set_authorizer
    auth_obj = Order
    auth_obj = @order if params[:id]
    auth_obj = @user if params[:user_id]

    @authorizer = OrderPolicy.new(current_user, auth_obj)
  end
end
