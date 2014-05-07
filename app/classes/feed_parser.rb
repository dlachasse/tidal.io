class FeedParser

	# Note that @feed always relates to ActiveRecord
	# copy of the Feed object. @feedjira will relate
	# to a Feedjira object

	def self.fetch url
		@feedjira = Feedjira::Feed.fetch_and_parse(url)
	end

	def self.load_feed url
		@feed = Feed.find_by(url: url)
	end

	def self.retrieve_entries url
		fetch(url)
		@feed ||= load_feed(url)
		@feedjira.entries.map { |article|	check_and_save_article article }
	end

	def self.check_and_save_article article
		Article.where(permalink: article.url).first_or_create!(
			title: article.title,
			permalink: article.url,
			body: article.content,
			published: article.published,
			feed_id: @feed.id)
	end

	def self.retrieve_name url
		fetch(url)
		@feedjira.title
	end

end