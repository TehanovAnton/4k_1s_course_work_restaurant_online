# frozen_string_literal:true

module Setups
  module Default
    extend ActiveSupport::Concern

    included do
      let!(:customer) { FactoryBot.create(:user, tr_type: 'Customer') }

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

    let!(:avenue_menu) { FactoryBot.create(:menu, :breakfast, restaurant: avenue_restaurant) }
    let!(:bergamo_menu) { FactoryBot.create(:menu, :breakfast, restaurant: bergamo_restaurant) }

    end
  end
end
