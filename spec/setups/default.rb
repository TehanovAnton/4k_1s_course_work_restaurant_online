# frozen_string_literal:true

require './spec/setups/users/customers_setup'
require './spec/setups/restaurants/restaurants_setup'

module Setups
  module Default
    extend ActiveSupport::Concern

    included do
      # let!(:customer) { FactoryBot.create(:user, tr_type: 'Customer') }
      include Setups::Users::CustomersSetup
      include Setups::Restaurants::RestaurantsSetup

      let!(:avenue_menu) { FactoryBot.create(:menu, :breakfast, restaurant: avenue_restaurant) }
      let!(:bergamo_menu) { FactoryBot.create(:menu, :breakfast, restaurant: bergamo_restaurant) }

    end
  end
end
