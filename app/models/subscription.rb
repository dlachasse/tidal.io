class Subscription < ActiveRecord::Base

	# VALIDATIONS
	validates :user_id, presence: true
	validates :feed_id, presence: true

	# ASSOCIATIONS
	belongs_to :user
	belongs_to :feed

	def self.create_subscription(user, feed)
		self.where(user_id: user, feed_id: feed).first_or_create!(user_id: user, feed_id: feed)
	end
end
