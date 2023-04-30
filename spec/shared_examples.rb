# frozen_string_literal: true

RSpec.shared_examples 'check post request status' do |action, status|
  it do
    response = post(action, params: params)
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

RSpec.shared_examples 'inlcude error message' do |error_message|
  it 'will not create invlaid record' do
    model.save
    expect(model.errors.messages.any?(error_message)).to be(true)
  end
end
