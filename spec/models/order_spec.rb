require 'rails_helper'

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
  end
end
