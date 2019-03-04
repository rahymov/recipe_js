require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.create(
      :email => "test@test.com",
      :password => "password",
      :password_confirmation => "password"
    )
  }
  it 'is valid with email, password, password_confirmation' do
    expect(user).to be_valid
  end
end
