module Authorization::RestaurantsAuthorizationApi
  ACTIONS = %i[can_create? can_update? can_destroy?].freeze
  MODEL_AUTH_ACTIONS = %i[can_update? can_destroy?].freeze
  MODEL_AUTH_CREATE_ACTION = %i[can_create?].freeze

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
    auth_obj = Restaurant
    auth_obj = @restaurant if params[:id]

    @authorizer = RestaurantPolicy.new(current_user, auth_obj)
  end
end
