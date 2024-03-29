# frozen_string_literal:true

module Setups
  module Restaurants
    module RestaurantsSetup
      extend ActiveSupport::Concern

      included do
        include Setups::Companies::CompaniesSetup

        let!(:restaurant) do
          FactoryBot.create(:restaurnat_with_tables, name: 'Avenue')
        end
      end
    end
  end
end
