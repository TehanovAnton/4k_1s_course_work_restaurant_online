# frozen_string_literal:true

module Setups
  module Users
    module CustomersSetup
      extend ActiveSupport::Concern

      included do
        let!(:customer) { FactoryBot.create(:user, tr_type: 'Customer') }
      end
    end
  end
end
