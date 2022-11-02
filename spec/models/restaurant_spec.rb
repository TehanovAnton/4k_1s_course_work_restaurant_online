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
end
