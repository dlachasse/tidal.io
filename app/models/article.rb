class Article < ActiveRecord::Base

	# VALIDATIONS
	validates :feed_id, presence: true

	# ASSOCIATIONS
	belongs_to :feed

	# SCOPES
	scope :newest, -> { order(published: :desc) }
	scope :batch,  -> (count) { limit(count) }
	scope :start,  -> (start) { offset(start) }

	# ALIAII?
	alias_attribute :content, :body
	alias_attribute :url, :permalink
end
