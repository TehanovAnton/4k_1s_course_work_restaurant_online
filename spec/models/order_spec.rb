require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#dishes' do
    context 'when order has dishes' do

      include_examples "model_relation", 'dishes' do        
        let(:restaurant) do 
          Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
        end

        let(:user) do
          User.create(name: 'obi van', email: 'kenoby@gmail.com')
        end 

        let(:menu) do
          Menu.create(name: 'italic', restaurant_id: restaurant.id)
        end

        let(:model) do
          order = Order.create(user_id: user.id, restaurant_id: restaurant.id)
          dish = Dish.create(name: 'pasta', menu_id: menu.id)
          order.dishes << dish

          return order
        end
      end
    end
  end

  describe '#tables' do
    context 'when order has tables' do

      include_examples "model_relation", 'tables' do        
        let(:restaurant) do 
          Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
        end

        let(:user) do
          User.create(name: 'obi van', email: 'kenoby@gmail.com')
        end 

        let(:model) do
          order = Order.create(user_id: user.id, restaurant_id: restaurant.id)
          table = Table.create(number: 1, restaurant_id: restaurant.id)
          order.tables << table

          return order
        end
      end
    end
  end
end
