require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe '#dishes' do
    context 'when menu has dishes' do

      include_examples "model_relation", 'dishes' do        
        let(:restaurant) do 
          Restaurant.create(name: 'restic', email: 'restic@gmail.com', address: 'mogilevskay-2')
        end

        let(:model) do
          menu = Menu.create(name: 'italic', restaurant_id: restaurant.id)
          Dish.create(name: 'pasta', menu_id: menu.id)

          return menu
        end
      end
    end
  end
end
