
require 'rails_helper'

RSpec.describe RestaurantsTeams::RestaurantsTeamsController, type: :controller do
  describe 'team' do
    include Setups::Users::CustomersSetup
    include Setups::Users::CooksSetup
    include Setups::Users::SuperAdminsSetup
    include Setups::Companies::CompaniesSetup
    include Setups::Restaurants::RestaurantsSetup
    include SpecHelpers::ApiAuthenticationHelpers

    before do
      response = login(super_admin)
      auth_params = get_auth_params_from_login_response_headers(response)
      @request.headers.merge!(auth_params)
    end

    context 'correct params' do
      before do
        restaurant.cooks << Cook.find(cook.id)
        restaurant.admins << super_admin
      end

      let(:params) do
        {
          id: restaurant.id
        }
      end

      include_examples 'check get request status', :team, :ok
    end
  end

  describe 'create_cook' do
    include Setups::Users::CustomersSetup
    include Setups::Users::SuperAdminsSetup
    include Setups::Companies::CompaniesSetup
    include Setups::Restaurants::RestaurantsSetup
    include SpecHelpers::ApiAuthenticationHelpers

    before do
      response = login(super_admin)
      auth_params = get_auth_params_from_login_response_headers(response)
      @request.headers.merge!(auth_params)
    end

    context 'wrong params' do
      context 'epmty params scope' do        
        let(:params) do
          {
            id: super_admin.id,
            user: {}
          }
        end
        
        include_examples 'check post request status', :create_cook, :unprocessable_entity
      end

      context 'no cook user binding params' do        
        let(:params) do
          {
            id: super_admin.id,
            user: {
              name: 'clone',
              email: 'clone@gmail.com',
              password: 'ewqqwe',
              password_confirmation: 'ewqqwe',
              type: 'Cook',
              cook_user_binding_attributes: {}
            }
          }
        end
        
        include_examples 'check post request status', :create_cook, :unprocessable_entity
      end

      context 'unexistent user_id in cook user binding params' do        
        let(:params) do
          {
            id: super_admin.id,
            user: {
              name: 'clone',
              email: 'clone@gmail.com',
              password: 'ewqqwe',
              password_confirmation: 'ewqqwe',
              type: 'Cook',
              cook_user_binding_attributes: { user_id: -1 }
            }
          }
        end
        
        include_examples 'check post request status', :create_cook, :unprocessable_entity
      end
    end

    context 'correct params' do
      context 'bind new cook to customer' do
        let(:params) do
          {
            id: restaurant.id,
            user: {
              name: 'clone',
              email: 'clone@gmail.com',
              password: 'ewqqwe',
              password_confirmation: 'ewqqwe',
              type: 'Cook',
              cook_user_binding_attributes: { user_id: customer.id },
              restaurants_cook_attributes: { restaurant_id: restaurant.id }
            }
          }
        end
  
        it 'creates cook wiht binding' do
          response = post(:create_cook, params: params)
          expect(response).to have_http_status(:ok)

          cook = Cook.last
          expect(cook.user.id).to be(customer.id)
        end
      end
    end

    context 'unauthorized requiest' do
      let(:params) do
        {
          id: restaurant.id,
          user: {
            name: 'clone',
            email: 'clone@gmail.com',
            password: 'ewqqwe',
            password_confirmation: 'ewqqwe',
            type: 'Cook',
            cook_user_binding_attributes: { user_id: customer.id },
            restaurants_cook_attributes: { restaurant_id: restaurant.id }
          }
        }
      end

      let(:admin) do
        FactoryBot.create(:user, tr_type: 'Admin')
      end

      before do
        response = login(admin)
        auth_params = get_auth_params_from_login_response_headers(response)
        @request.headers.merge!(auth_params)
      end
  
      include_examples 'check post request status', :create_cook, :unprocessable_entity
      
      it 'include response error message' do
        response = post(:create_cook, params: params)
        expect(JSON.parse(response.body)).to eq({"error"=>"not allowed to create_cook? this Restaurant"})
      end
    end
  end
end
