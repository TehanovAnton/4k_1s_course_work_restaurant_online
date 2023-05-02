# frozen_string_literal:true

module Setups
  module Restaurants
    module RestaurantWithMenusSetup
      extend ActiveSupport::Concern

      included do
        include Setups::Companies::CompaniesSetup

        let!(:restaurant) do
          restaurant = FactoryBot.build(:restaurnat_with_menus)
          restaurant.save
          restaurant
        end
      end
    end
  end
end
