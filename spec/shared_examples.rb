# frozen_string_literal: true

RSpec.shared_examples 'empty params scope post request' do |action|
  it do
    binding.pry
    response = post(action, params: params)
    expect(response).to have_http_status(status)
  end
end
