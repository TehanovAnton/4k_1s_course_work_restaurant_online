require 'rails_helper'
require './spec/setups/default'

RSpec.describe Order, type: :model do
  describe 'create' do
    include Setups::Default

    context 'unknown dishes' do
      let!(:order_with_unknown_dishes) do
        dishes = []
        bergamo_menu.dishes.each do |dish|
          dishes << { dish_id: dish.id }
        end

        Order.new(
          user_id: customer.id,
          restaurant_id: avenue_restaurant.id,
          orders_dishes_attributes: dishes
        )
      end

      it 'does not create order with unknown dishes' do
        expect(order_with_unknown_dishes.save).to be(false)
        expect(order_with_unknown_dishes.errors.messages).not_to be_empty
      end
    end

    context 'update in less than an hour' do
      let!(:order) do
        orders_dishes = [{ dish_id: avenue_restaurant.dishes.first.id }]
        reservation_attributes = {
          place_type: 'outside',
          start_at: Time.now + 30.minutes,
          end_at: Time.now + 30.minutes
        }

        FactoryBot.create(:order_with_dishes,
                          user: customer,
                          restaurant: avenue_restaurant,
                          orders_dishes: orders_dishes,
                          reservation_attributes: reservation_attributes
                         )
      end

      let(:params) do
        {
          orders_dishes_attributes: {
            id: order.orders_dishes.first.id,
            dish_id: avenue_restaurant.dishes.last
          }
        }
      end

      it "can't be updated" do
        expect(order.update(**params)).to be false
      end
    end
  end
end
