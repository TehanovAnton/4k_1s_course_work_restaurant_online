# frozen_string_literal: true

RSpec.shared_examples 'relation' do |relation|
  it 'presences' do
    relation_value = restaurant.method(relation).call
    expect(relation_value).to be
    expect(relation_value).not_to be_empty
  end
end