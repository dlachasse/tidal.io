class Subscription < ActiveRecord::Base

	# VALIDATIONS
	validates :user_id, presence: true
	validates :feed_id, presence: true

	# ASSOCIATIONS
	belongs_to :user
	belongs_to :feed
end
