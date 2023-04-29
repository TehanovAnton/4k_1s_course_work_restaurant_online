# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'create_cook' do
    include Setups::Users::CustomersSetup
    include Setups::Users::SuperAdminsSetup
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
            id: super_admin.id,
            user: {
              name: 'clone',
              email: 'clone@gmail.com',
              password: 'ewqqwe',
              password_confirmation: 'ewqqwe',
              type: 'Cook',
              cook_user_binding_attributes: { user_id: customer.id }
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
  end
end
