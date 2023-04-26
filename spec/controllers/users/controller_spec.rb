# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'create_cook' do
    context 'wrong params' do
      context 'epmty params scope' do
        let(:params) do
          {
            user: {}
          }
        end
        
        it do
          response = post(:create_cook, params: params)
          expect(response).to have_http_status(status)
        end
        # include_examples 'empty params scope post request', :create_cook
      end


    end
  end
end
