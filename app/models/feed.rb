class Feed < ActiveRecord::Base

	# VALIDATIONS
	# validates :feed_url, presence: true

	# ASSOCIATIONS
	has_many :users, through: :subscriptions, as: :subscribers
	has_many :articles

	# CALLBACKS
	before_create :retrieve_feed_data
	after_create :fetch_and_save_favicon
	after_create :pull_down_feed
	after_create :update_last_checked
	after_update :update_last_checked

	# SCOPES
	scope :requiring_update, -> { where('last_checked < ? OR last_checked IS NULL', 20.minutes.ago).pluck(:feed_url) }

	def pull_down_feed
		ArticleFetcherWorker.perform_async(self.feed_url)
	end

	def retrieve_feed_data
		feed = FeedParser.retrieve_feed_data(self.feed_url)
		self.name 		 = feed[:name]
		self.url	 		 = feed[:url]
	end

	def update_last_checked
		self.last_checked = Time.now
	end

	def fetch_and_save_favicon
		FaviconFetcherWorker.perform_async(self.id)
	end

	def self.update_feeds
		self.requiring_update.map { |feed_url| ArticleFetcherWorker.perform_async(feed_url) }
	end

	def self.update_favicons
		self.all.pluck(:id).map { |id| FaviconFetcherWorker.perform_async(id) }
	end

end
