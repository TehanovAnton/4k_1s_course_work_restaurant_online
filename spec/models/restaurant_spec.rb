require 'rails_helper'

RSpec.shared_examples 'invalid restaurant' do
  let(:model) { restaurant }

  include_examples 'invalid model'
end

RSpec.describe Restaurant, type: :model do
  describe 'create' do
    include Setups::Users::SuperAdminsSetup
    include Setups::Companies::CompaniesSetup

    context 'wrong params' do
      context 'no company' do
        let(:restaurant) do
          FactoryBot.build(:restaurant, companies_restaurant_attributes: {})
        end

        include_examples 'invalid restaurant'
        include_examples 'model inlcude error message', [:"companies_restaurant.company", ["is missing"]]
      end

      context 'correct params' do
        let(:model) do
          FactoryBot.build(:restaurant)
        end

        include_examples 'valid model'

        it 'has company' do
          model.save
          expect(model.company).to be
        end
      end
    end
  end
end
