# frozen_string_literal:true

module Setups
  module Orders
    module OutsideOrdersSetup
      extend ActiveSupport::Concern

      included do
        include Setups::Users::CustomersSetup
        include Setups::Restaurants::RestaurantWithMenusSetup

        let!(:order) do
          FactoryBot.create(:outside_order)
        end
      end
    end
  end
end
