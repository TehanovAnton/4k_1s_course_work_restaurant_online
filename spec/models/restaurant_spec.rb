require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'create' do
    context 'normal setup' do
      let(:restaurant) do
        Restaurant.new(
          name: 'New Restaurant 1',
          email: 'newrestaurant1@gmail.com',
          address: 'new-rest-street14'
        )
      end

      it do
        expect { restaurant.save }.to change { Restaurant.count }.by(1)
      end
    end
  end
end
