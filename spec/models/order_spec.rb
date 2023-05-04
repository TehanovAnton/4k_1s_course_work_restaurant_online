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

RSpec.shared_examples 'invalid order period' do |order_factory, start_at, end_at, error_message|
  let(:order) do
    FactoryBot.build(
      order_factory,
      reservation_attributes: {
        start_at: start_at,
        end_at: end_at,
        place_type: :inside,
        table: restaurant.tables.first
      }
    )
  end

  include_examples 'invalid order'
  include_examples 'model inlcude error message', error_message
end

RSpec.shared_examples 'order reservation nil property will cause error' do |property, error_message|
  let(:order) do
    reservation = {
      start_at: DateTime.now + 1.hours,
      end_at: DateTime.now + 2.hours,
      place_type: :inside,
      table: restaurant.tables.first
    }
    
    reservation[property] = nil

    FactoryBot.build(
      :inside_order_through_attributes,
      reservation_attributes: reservation
    )
  end

  include_examples 'invalid order'
  include_examples 'order inlcude error message', error_message
end

RSpec.describe Order, type: :model do

  describe 'order' do
    include Setups::Users::CustomersSetup
    include Setups::Restaurants::RestaurantWithMenusSetup

    context 'wrong params' do
      context 'without reservation' do
        include_examples 'model nil property will cause error', :outside_order, :reservation, [:reservation, ["Could not create order without reservation."]]
      end
  
      context 'without restaurant' do
        include_examples 'model nil property will cause error', :outside_order, :restaurant, [:restaurant, ["Could not create order without resturant.", "must exist"]]
      end
  
      context 'without user' do
        include_examples 'model nil property will cause error', :outside_order, :user, [:user, ["Could not create order without user.", "must exist"]]    
      end

      context 'without start_at' do
        include_examples 'order reservation nil property will cause error', :start_at, [:"reservation.start_at", ["can't be blank"]]
      end
    end

    context 'correct params' do
      let(:order) do
        FactoryBot.build(:outside_order)
      end

      include_examples 'valid order'

      it 'will have required association' do
        order.save

        %i[user restaurant reservation].each do |property|
          expect(order.method(property).call).to be
        end
      end
    end
  end

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
    end

    context 'correct params' do
      let(:order) do
        FactoryBot.build(:outside_order)
      end

      include_examples 'valid order'

      it 'will have required association' do
        order.save
        expect(order.dishes).to be
      end
    end
  end

  describe 'inside orders' do
    include Setups::Users::CustomersSetup
    include Setups::Restaurants::RestaurantWithMenusSetup

    context 'wrong params' do
      context 'invalid reservation period' do
        context 'order start later than end' do
          include_examples 'invalid order period',
                           :inside_order_through_attributes, 
                           DateTime.now + 2.hours, 
                           DateTime.now, 
                           [:"reservation.base", ["Reservation start time can't be earlier than end."]]          
        end

        context 'order earlier than now' do
          include_examples 'invalid order period',
                           :inside_order_through_attributes, 
                           DateTime.now - 2.hours, 
                           DateTime.now - 1.hours, 
                           [:"reservation.base",["Reservation start time can't be earlier than now."]]
        end

        context 'order end intersect another order' do
          let!(:later_order) do
            now = DateTime.now
            start_at = now + 2.hours
            end_at = now + 4.hours
            FactoryBot.create(
              :inside_order_through_attributes,
              reservation_attributes: {
                start_at: start_at,
                end_at: end_at,
                place_type: :inside,
                table: restaurant.tables.first
              }
            )
          end

          include_examples 'invalid order period',
                           :inside_order_through_attributes,
                           DateTime.now + 1.hours,
                           DateTime.now + 3.hours,
                           [:"reservation.base", ["It seems there is another reservation at that time", "It seems your time covers other reservations"]]
        end

        context 'order start intersect another order' do
          let!(:early_order) do
            now = DateTime.now
            start_at = now + 1.hours
            end_at = now + 3.hours
            FactoryBot.create(
              :inside_order_through_attributes,
              reservation_attributes: {
                start_at: start_at,
                end_at: end_at,
                place_type: :inside,
                table: restaurant.tables.first
              }
            )
          end

          include_examples 'invalid order period',
                           :inside_order_through_attributes,
                           DateTime.now + 2.hours,
                           DateTime.now + 4.hours,
                           [:"reservation.base", ["It seems there is another reservation at that time", "It seems your time covers other reservations"]]
        end

        context 'order fully inside another order' do
          let!(:early_order) do
            now = DateTime.now
            start_at = now + 1.hours
            end_at = now + 4.hours
            FactoryBot.create(
              :inside_order_through_attributes,
              reservation_attributes: {
                start_at: start_at,
                end_at: end_at,
                place_type: :inside,
                table: restaurant.tables.first
              }
            )
          end

          include_examples 'invalid order period',
                           :inside_order_through_attributes,
                           DateTime.now + 2.hours,
                           DateTime.now + 3.hours,
                           [:"reservation.base", ["It seems there is another reservation at that time", "It seems your time covers other reservations"]]
        end
      end

      context 'without table' do
        include_examples 'order reservation nil property will cause error', :table, [:"reservation.table", ["Could not create reservation without table."]]
      end

      context 'without end_at' do
        include_examples 'order reservation nil property will cause error', :end_at, [:"reservation.end_at", ["can't be blank"]]
      end
    end
  end
end
