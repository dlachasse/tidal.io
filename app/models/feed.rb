class Feed < ActiveRecord::Base

	# VALIDATIONS

	# ASSOCIATIONS
	has_many :users, through: :subscriptions, as: :subscribers
	has_many :articles

end
