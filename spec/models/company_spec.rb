require 'rails_helper'

RSpec.shared_examples 'invalid company' do 
  let(:model) do
    company
  end

  include_examples 'invalid model'
end

RSpec.shared_examples 'valid company' do 
  let(:model) do
    company
  end

  include_examples 'valid model'
end


RSpec.describe Company, type: :model do
  describe 'create' do
    include Setups::Users::CustomersSetup
    include Setups::Users::SuperAdminsSetup

    context 'wrong params' do
      context 'empty super_admins_company' do
        let(:company) do
          FactoryBot.build(:company, super_admins_company: SuperAdminsCompany.new)
        end
  
        include_examples 'invalid company'
        include_examples 'inlcude error message', [:"super_admins_company.super_admin", ["is missing"]]
      end

      context 'no name' do
        let(:company) do
          FactoryBot.build(:company, name: '')
        end
  
        include_examples 'invalid company'
        include_examples 'inlcude error message', [:"name", ["Could not create Company without Name"]]
      end
      
      context 'no email' do
        let(:company) do
          FactoryBot.build(:company, email: '')
        end
  
        include_examples 'invalid company'
        include_examples 'inlcude error message', [:"email", ["Could not create Company without Email"]]
      end

      context 'trying add new company super_admin' do
        let(:company) do
          FactoryBot.create(:company)
        end

        let(:model) do
          new_super_admin = FactoryBot.create(:user, tr_type: 'SuperAdmin', name: 'new_admin')
          super_admins_company = FactoryBot.build(:super_admins_company, company: company, user_id: new_super_admin.id)
        end
  
        include_examples 'invalid model'
        include_examples 'inlcude error message', [:"user_id", ["Company can have only one super admin account."]]
      end
    end

    context 'correct params' do
      let(:company) do
        FactoryBot.build(:company)
      end

      include_examples 'valid company'

      context 'with nested attributes' do
        let(:company) do
          FactoryBot.build(:company, :admin_nested_attributes)
        end
  
        include_examples 'valid company'
      end
    end
  end
end
