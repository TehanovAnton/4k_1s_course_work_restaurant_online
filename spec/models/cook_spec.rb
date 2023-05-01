require 'rails_helper'

RSpec.shared_examples 'invalid cook' do 
  let(:model) { cook }
  
  include_examples 'invalid model'
end

RSpec.shared_examples 'valid cook' do 
  let(:model) { cook }
  
  include_examples 'valid model'
end

RSpec.describe Cook, type: :model do
  describe 'invalid cook' do
    include Setups::Users::CustomersSetup

    let(:cook) do
      FactoryBot.build(:cook, tr_type: 'Cook', restaurants_cook_attributes: {})
    end

    include_examples 'invalid cook'
    include_examples 'model inlcude error message', [:"restaurants_cook.restaurant", ["must exist"]]
  end

  describe 'valid cook' do
    include Setups::Users::SuperAdminsSetup
    include Setups::Users::CustomersSetup
    include Setups::Companies::CompaniesSetup
    include Setups::Restaurants::RestaurantsSetup

    let(:cook) do
      FactoryBot.build(:cook, tr_type: 'Cook')
    end

    include_examples 'valid cook'
  end
end
