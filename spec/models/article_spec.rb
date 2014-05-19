require 'spec_helper'

describe Article do

	it 'has a valid factory' do
		expect(build(:article)).to be_valid
	end

	it { should belong_to(:feed) }
	it { should validate_presence_of(:feed_id) }

	it 'properly populates permalink when missing domain' do # alliterations!
		pending('Must find proper way to populate this data')
	end
end
