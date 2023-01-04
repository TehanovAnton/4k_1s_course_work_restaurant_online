module Setups
  module Default
    extend ActiveSupport::Concern

    included do
      let!(:customer) { FactoryBot.create(:user, tr_type: 'Customer') }

      let!(:avenue_restaurant) { FactoryBot.create(:restaurant, :with_tables) }
      let!(:bergamo_restaurant) { FactoryBot.create(:restaurant, name: 'bergamo') }

      let!(:avenue_menu) { FactoryBot.create(:menu, :breakfast, restaurant: avenue_restaurant) }
      let!(:bergamo_menu) { FactoryBot.create(:menu, :breakfast, restaurant: bergamo_restaurant) }
    end
  end
end
