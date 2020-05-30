require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a name' do
    user = User.create(name: 'Alice')

    expect(user.name).to eq 'Alice'
  end
end
