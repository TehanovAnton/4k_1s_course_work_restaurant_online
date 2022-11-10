require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe '#orders' do
    context 'when dish has orders' do

      include_examples "model_relation", 'orders' do        
        let(:restaurant) do 
          Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
        end

        let(:user) do
          User.create(name: 'obi van', email: 'kenoby@gmail.com', password: 'ewqqwe')
        end 

        let(:menu) do
          Menu.create(name: 'italic', restaurant_id: restaurant.id)
        end

        let(:model) do
          order = Order.create(user_id: user.id, restaurant_id: restaurant.id)
          dish = Dish.create(name: 'pasta', menu_id: menu.id)
          order.dishes << dish

          return dish
        end
      end
    end
  end
end
