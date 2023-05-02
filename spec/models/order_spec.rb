require 'rails_helper'

RSpec.shared_examples 'invalid order' do
  let(:model) do
    order
  end

  include_examples 'invalid model'
end

RSpec.shared_examples 'valid order' do
  let(:model) do
    order
  end

  include_examples 'valid model'
end

RSpec.shared_examples 'order inlcude error message' do |error_message|
  let(:model) do
    order
  end

  include_examples 'model inlcude error message', error_message
end

RSpec.describe Order, type: :model do
  describe 'outside orders' do
    include Setups::Users::CustomersSetup
    include Setups::Restaurants::RestaurantWithMenusSetup

    context 'wrong params' do
      context 'without dishes' do
        let(:order) do
          FactoryBot.build(:outside_order, dishes: [])
        end
  
        include_examples 'invalid order'
        include_examples 'order inlcude error message', [:orders_dishes, ["Could not create outside order without dishes."]]
      end

      context 'without reservation' do
        include_examples 'model nil property will cause error', :outside_order, :reservation, [:reservation, ["Could not create order without reservation."]]
      end

      context 'without restaurant' do
        include_examples 'model nil property will cause error', :outside_order, :restaurant, [:restaurant, ["Could not create order without resturant.", "must exist"]]
      end

      context 'without user' do
        include_examples 'model nil property will cause error', :outside_order, :user, [:user, ["Could not create order without user.", "must exist"]]    
      end
    end

    context 'correct params' do
      let(:order) do
        FactoryBot.build(:outside_order)
      end

      include_examples 'valid order'

      it 'will have required association' do
        order.save

        %i[user restaurant reservation dishes].each do |property|
          expect(order.method(property).call).to be
        end
      end
    end
  end
end
