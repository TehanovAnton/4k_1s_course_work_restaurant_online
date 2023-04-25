# frozen_string_literal: true

require 'rails_helper'
require './spec/setups/users/customers_setup'

RSpec.describe UsersController, type: :controller do
  describe 'reset_password' do
    include Setups::Users::CustomersSetup

    before do
      sign_in customer
    end
  
    context 'wrong params' do
      context 'empty params scope' do
        let(:params) do
          { reset_password: {} }
        end
  
        it do
          response = put(:reset_password, params: params)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'no email' do
        let(:params) do
          { 
            reset_password: { 
              passwords: {
                password: 'ewqqwe', 
                password_confirmation: 'ewqqwe' 
              }
            }
          }
        end
  
        it do
          response = put(:reset_password, params: params)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'no passwords' do
        let(:params) do
          { 
            reset_password: {
              email: customer.email, 
              passwords: {}
            }
          }
        end
  
        it do
          response = put(:reset_password, params: params)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'empty passwords' do
        let(:params) do
          { 
            reset_password: {
              email: customer.email, 
              passwords: {
                password: '',
                password_confirmation: ''
              }
            }
          }
        end
  
        it do
          response = put(:reset_password, params: params)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'passwords are not same' do
        let(:params) do
          {
            reset_password: {
              email: customer.email, 
              passwords: {
                password: 'ewqqwe',
                password_confirmation: 'qweewq'
              }
            }
          }
        end
  
        it do
          response = put(:reset_password, params: params)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'correct params' do
      let(:params) do
        {   
          reset_password: {
            email: customer.email, 
            passwords: {
              password: 'ewqqwe',
              password_confirmation: 'ewqqwe'
            }
          }
        }
      end

      it do
        response = put(:reset_password, params: params)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
