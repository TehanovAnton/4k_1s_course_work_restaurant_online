# frozen_string_literal: true

RSpec.shared_examples 'check post request status' do |action, status|
  it do
    response = post(action, params: params)
    expect(response).to have_http_status(status)
  end
end

RSpec.shared_examples 'check get request status' do |action, status|
  it do
    response = get(action, params: params)
    expect(response).to have_http_status(status)
  end
end

RSpec.shared_examples 'invalid model' do 
  it 'will not create invlaid record' do
    model.save    
    expect(model).not_to be_valid
  end
end

RSpec.shared_examples 'valid model' do 
  it 'will create vlaid record' do
    model.save
    expect(model).to be_valid
  end
end

RSpec.shared_examples 'model inlcude error message' do |error_message|
  it 'has record error' do
    model.save
    expect(model.errors.messages.any?(error_message)).to be(true)
  end
end

RSpec.shared_examples 'model nil property will cause error' do |factory, property, error_message|
  let(:model) do
    FactoryBot.build(factory, property => nil)
  end

  include_examples 'invalid model'
  include_examples 'model inlcude error message', error_message
end
