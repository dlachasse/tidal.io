require 'spec_helper'

describe Feed do

  it 'has a valid factory' do
		expect(build(:feed)).to be_valid
	end

	it { should have_many(:articles) }

end
