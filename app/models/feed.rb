class Feed < ActiveRecord::Base

	# VALIDATIONS
	validates :url, presence: true

	# ASSOCIATIONS
	has_many :users, through: :subscriptions, as: :subscribers
	has_many :articles

	# CALLBACKS
	before_save :retrieve_name
	after_create :pull_down_feed
	after_create :update_last_checked
	after_update :update_last_checked

	# SCOPES
	scope :requiring_update, -> { where('last_checked < ? OR last_checked IS NULL', 20.minutes.ago).pluck(:url) }

	def pull_down_feed
		ArticleFetcherWorker.perform_async(self.url)
	end

	def retrieve_name
		self.name = FeedParser.retrieve_name(self.url)
	end

	def update_last_checked
		self.last_checked = Time.now
	end

	def self.update_feeds
		self.requiring_update.map { |url| ArticleFetcherWorker.perform_async(url) }
	end

end
