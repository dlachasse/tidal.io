class Feed < ActiveRecord::Base

	# VALIDATIONS
	validates :url, presence: true

	# ASSOCIATIONS
	has_many :users, through: :subscriptions, as: :subscribers
	has_many :articles

	# CALLBACKS
	before_save :pull_down_feed

	def pull_down_feed
		@feed = Feedjira::Feed.fetch_and_parse(self.url)
		assign_name
	end

	def assign_name
		self.name = @feed.title
	end

end
