require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '#tables' do
    context 'when restaurant has tables' do

      include_examples "relation", 'tables' do
        let(:restaurant) do 
          tabel = Table.create(number: 1)
          restaurant = Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
          restaurant.tables << tabel
    
          return restaurant
        end
      end

    end
  end  

  describe '#menus' do
    context 'when restaurant has menus' do

      include_examples "relation", 'menus' do
        let(:restaurant) do 
          menu = Menu.create(name: 'belarusian')
          restaurant = Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
          restaurant.menus << menu
    
          return restaurant
        end
      end

    end
  end

  describe '#orders' do
    context 'when restaurant has orders' do

      include_examples "relation", 'orders' do
        let(:user) do
          User.create(name: 'obi van', email: 'kenoby@gmail.com')
        end

        let(:restaurant) do 
          restaurant = Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
          oreder = Order.create(user_id: user.id, restaurant_id: restaurant.id)
          restaurant.orders << oreder

          return restaurant
        end
      end
    end
  end
  
  describe '#messages' do
    context 'when restaurant has messages' do

      include_examples "relation", 'messages' do
        let(:user) do
          User.create(name: 'obi van', email: 'kenoby@gmail.com')
        end

        let(:restaurant) do 
          restaurant = Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
          message = Message.create(user_id: user.id, restaurant_id: restaurant.id, text: 'any')
          restaurant.messages << message

          return restaurant
        end
      end
    end
  end
end
