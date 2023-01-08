#  frozen_string_literal: true
module Authorization::MenusAuthorizationApi
  extend ActiveSupport::Concern

  ACTIONS = %i[can_create? can_update? can_destroy?].freeze
  MODEL_AUTH_ACTIONS = %i[can_update? can_destroy?].freeze
  MODEL_AUTH_CREATE_ACTION = %i[can_create?].freeze

  included do
    before_action :set_authorizer, only: Authorization::MenusAuthorizationApi::ACTIONS

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
      auth_obj = @model if params[:id]

      @authorizer = MenuPolicy.new(current_user, auth_obj)
    end
  end
end
