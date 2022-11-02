require 'rails_helper'

RSpec.describe Table, type: :model do
  describe '#orders' do
    context 'when user has orders' do

      include_examples "model_relation", 'orders' do        
        let(:restaurant) do 
          Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
        end

        let(:user) do
          User.create(name: 'obi van', email: 'kenoby@gmail.com')
        end

        let(:order) do
          Order.create(user_id: user.id, restaurant_id: restaurant.id)
        end

        let(:model) do
          table = Table.create(number: 1, restaurant_id: restaurant.id)
          order.tables << table

          return table
        end
      end
    end
  end
end
