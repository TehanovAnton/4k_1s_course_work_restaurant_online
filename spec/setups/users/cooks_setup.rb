# frozen_string_literal:true

module Setups
  module Users
    module CooksSetup
      extend ActiveSupport::Concern

      included do
        let!(:cook) { FactoryBot.create(:user, tr_type: 'Cook') }
      end
    end
  end
end
