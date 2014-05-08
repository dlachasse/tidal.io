require 'spec_helper'

describe Article do

	it 'has a valid factory' do
		expect(build(:article)).to be_valid
	end

	it { should belong_to(:feed) }
	it { should validate_presence_of(:feed_id) }

	it 'properly populates permalink when missing domain' do # alliterations!
		sweet_blog = create(:feed, url: 'http://blog.sensible.io/rss')
		FeedParser.retrieve_entries(sweet_blog.url)
		expect(sweet_blog.articles.pluck(:permalink)).to include('http://blog.sensible.io/rss/2013/08/19/postgresql-basics-by-example.html')
	end
end
