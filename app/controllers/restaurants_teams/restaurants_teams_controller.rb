# frozen_string_literal:true

module RestaurantsTeams
  class RestaurantsTeamsController < BaseController
    def create_cook
      super

      create_service = Models::Creaters::CookCreater.new(create_cook_params)
      create_service.create
  
      render(**create_service.response)
    rescue Pundit::NotAuthorizedError => e
      wrong_params(message: e.message)
    rescue StandardError => e
      wrong_params
    end

    def team
      super

      teamates = [] + RestaurantsAdminsBlueprint.render_as_hash(@model.restaurants_admins, view: :with_user)
      teamates += RestaurantsCookBlueprint.render_as_hash(@model.restaurants_cooks, view: :with_user)

      render(json: teamates)
    end

    private 

    def create_cook_params
      params.require(:user).permit(User::PARAMS)
    end
  end
end
