# frozen_string_literal:true

module Setups
  module Restaurants
    module ResturantsSetup
      extend ActiveSupport::Concern

      included do
        let!(:avenue_restaurant) do
          avenue_restaurant = FactoryBot.build(:restaurnat_with_tables, name: 'Avenue', email: 'avenue@gmail.com')
          avenue_restaurant.save
          avenue_restaurant
        end
  
        let!(:bergamo_restaurant) do
          bergamo_restaurant = FactoryBot.build(:restaurant, name: 'bergamo', email: 'bergamo@gmail.com')
          bergamo_restaurant.save
          bergamo_restaurant
        end
      end
    end
  end
end
