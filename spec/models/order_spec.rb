require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'create' do
    let!(:customer) { FactoryBot.create(:user, tr_type: 'Customer') }

    let!(:avenue_restaurant) { FactoryBot.create(:restaurant) }
    let!(:bergamo_restaurant) { FactoryBot.create(:restaurant, name: 'bergamo') }

    let!(:avenue_menu) { FactoryBot.create(:menu, :breakfast, restaurant: avenue_restaurant) }
    let!(:bergamo_menu) { FactoryBot.create(:menu, :breakfast, restaurant: bergamo_restaurant) }

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
