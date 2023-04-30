# frozen_string_literal:true

module Setups
  module Companies
    module CompaniesSetup
      extend ActiveSupport::Concern

      included do
        let!(:company) { FactoryBot.create(:company) }
      end
    end
  end
end
