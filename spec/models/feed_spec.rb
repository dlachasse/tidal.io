require 'spec_helper'

describe Feed do
	let(:feed) { build(:feed, url: 'http://daringfireball.net/index.xml', name: nil) }
	subject { build(:feed) }

	it { should be_valid }
	it { should have_many(:articles) }
	it { should validate_presence_of(:url) }

	context 'creating new feed' do

		it 'creates a new enqueued job' do
			new_feed = create(:feed)
			expect(ArticleFetcherWorker).to have_enqueued_job(new_feed.url)
		end

	end

	describe '#retrieve_name' do

		it 'finds correct title from feed' do
			expect(feed.retrieve_name).to eq 'Daring Fireball'
		end

	end

end
