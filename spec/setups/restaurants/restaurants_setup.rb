# frozen_string_literal:true

module Setups
  module Restaurants
    module RestaurantsSetup
      extend ActiveSupport::Concern

      included do
        let!(:restaurant) do
          restaurant = FactoryBot.create(:restaurnat_with_tables, name: 'Avenue')
        end
      end
    end
  end
end
