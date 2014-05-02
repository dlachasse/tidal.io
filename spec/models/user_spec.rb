require 'spec_helper'

describe User do
  it "has a valid factory" do
  	expect(build(:user)).to be_valid
  end

  it { should validate_presence_of :email }

  it "is invalid without email" do
  	expect(build(:invalid_user)).to_not be_valid
  end
end
