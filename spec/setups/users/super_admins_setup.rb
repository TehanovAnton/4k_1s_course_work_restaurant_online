# frozen_string_literal:true

module Setups
  module Users
    module SuperAdminsSetup
      extend ActiveSupport::Concern

      included do
        let!(:super_admin) { FactoryBot.create(:user, tr_type: 'SuperAdmin') }
      end
    end
  end
end
