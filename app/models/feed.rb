class Feed < ActiveRecord::Base

	# VALIDATIONS
	validates :url, presence: true

	# ASSOCIATIONS
	has_many :users, through: :subscriptions, as: :subscribers
	has_many :articles

	after_create :pull_down_feed
	before_save :retrieve_name

	def pull_down_feed
		ArticleFetcherWorker.perform_async(self.url)
	end

	def retrieve_name
		self.name = FeedParser.retrieve_name(self.url)
	end

end
