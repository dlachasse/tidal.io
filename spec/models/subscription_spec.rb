require 'spec_helper'

describe Subscription do

	it 'has a valid factory' do
		expect(build(:subscription)).to be_valid
	end

	it { should belong_to :user }
	it { should validate_presence_of :user_id }
	it { should validate_presence_of :feed_id }

end
