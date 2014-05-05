class Feed < ActiveRecord::Base

	# VALIDATIONS
	validates :url, presence: true

	# ASSOCIATIONS
	has_many :users, through: :subscriptions, as: :subscribers
	has_many :articles

end
