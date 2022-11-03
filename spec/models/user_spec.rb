require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#orders' do
    context 'when user has orders' do

      include_examples "model_relation", 'orders' do        
        let(:restaurant) do 
          Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
        end

        let(:model) do
          user = User.create(name: 'obi van', email: 'kenoby@gmail.com')
          oreder = Order.create(user_id: user.id, restaurant_id: restaurant.id)

          return user
        end
      end
    end
  end
  
  describe '#messages' do
    context 'when user has messages' do

      include_examples "model_relation", 'messages' do        
        let(:restaurant) do 
          Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
        end

        let(:model) do
          user = User.create(name: 'obi van', email: 'kenoby@gmail.com')
          message = Message.create(user_id: user.id, restaurant_id: restaurant.id, text: 'any')

          return user
        end
      end
    end
  end
end
