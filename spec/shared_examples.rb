# frozen_string_literal: true

RSpec.shared_examples 'check post request status' do |action, status|
  it do
    response = post(action, params: params)
    expect(response).to have_http_status(status)
  end
end
