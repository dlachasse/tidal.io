class Article < ActiveRecord::Base

	# VALIDATIONS
	validates :feed_id, presence: true

	# ASSOCIATIONS
	belongs_to :feed
end
