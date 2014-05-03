require 'spec_helper'

describe Article do

	it 'has a valid factory' do
		expect(build(:article)).to be_valid
	end

	it { should belong_to(:feed) }
	it { should validate_presence_of(:feed_id) }

end
