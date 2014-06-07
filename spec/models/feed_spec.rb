require 'spec_helper'

describe Feed do
	let(:feed) { build(:feed, url: 'http://daringfireball.net/index.xml', name: nil) }
	subject { build(:feed) }

	it { should be_valid }
	it { should have_many(:articles) }
	it { should validate_presence_of(:url) }

	context 'callbacks' do

		describe '#retrieve_name' do

			it 'finds correct title from feed before saving' do
				expect(feed.retrieve_name).to eq 'Daring Fireball'
			end

		end

		context 'after_create' do

			before :each do
				@current_time = Time.now
				Timecop.freeze(@current_time)
				@new_feed = create(:feed, url: 'http://swashcap.com/feed/', name: nil)
			end

			it 'creates new favicon worker' do #fetch_and_save_favicon
				expect(FaviconFetcherWorker).to have_enqueued_job(@new_feed.id)
			end

			it 'creates a new feed worker' do #pull_down_feed
				expect(ArticleFetcherWorker).to have_enqueued_job(@new_feed.url)
			end

			it 'refreshes update timestamp' do #pull_down_feed
				expect(@new_feed.last_checked).to eq @current_time
			end

		end

	end


end
