require 'spec_helper'

describe User do
  it "has a valid factory" do
  	expect(build(:user)).to be_valid
  end

  it 'has a valid factory with associations' do
    expect(build(:user_with_subscriptions)).to be_valid
  end

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_confirmation_of :password }
  it { should have_many(:feeds).through(:subscriptions) }

  it "is invalid without email" do
  	expect(build(:invalid_user)).to_not be_valid
  end
end
