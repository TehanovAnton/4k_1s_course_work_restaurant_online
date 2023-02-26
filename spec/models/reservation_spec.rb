require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'create' do
    include Setups::Default

    let(:order) do
      dishes = []
      avenue_menu.dishes.each do |dish|
        dishes << { dish_id: dish.id }
      end

      Order.create(
        user_id: customer.id,
        restaurant_id: avenue_restaurant.id,
        orders_dishes_attributes: dishes
      )
    end

    context 'with end time earlier than start' do
      let(:reservation) do
        start_at = DateTime.new(2023, 1, 5, 12)
        end_at = start_at - 1.hour
        table = avenue_restaurant.tables.first

        FactoryBot.build(
          :reservation,
          :inside,
          start_at: start_at,
          end_at: end_at,
          order_id: order.id,
          table_id: table.id
        )
      end

      it 'does not creat reservation with invalid time' do
        expect(reservation.save).to be(false)
        expect(reservation.errors.messages).not_to be_empty
      end
    end

    context 'with not uniq end time' do
      let!(:reservation_at_same_time) do
        start_at = DateTime.new(2023, 1, 5, 12)
        end_at = start_at + 1.hour
        table = avenue_restaurant.tables.first

        FactoryBot.create(
          :reservation,
          :inside,
          start_at: start_at,
          end_at: end_at,
          order_id: order.id,
          table_id: table.id
        )
      end

      let(:reservation) do
        start_at = DateTime.new(2023, 1, 5, 11)
        end_at = start_at + 4.hour
        table = avenue_restaurant.tables.first

        FactoryBot.build(
          :reservation,
          :inside,
          start_at: start_at,
          end_at: end_at,
          order_id: order.id,
          table_id: table.id
        )
      end

      it 'does not creat reservation with invalid time' do
        expect(reservation.save).to be(false)
        expect(reservation.errors.messages).not_to be_empty
      end
    end
  end
end
