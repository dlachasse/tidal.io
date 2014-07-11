class RSSValidation

	def initialize feed_url
		@feed_url = feed_url
		@checked = false
	end

	def discover_rss
		feeds = Feedbag.find @feed_url
		if feeds.length > 0
			feeds
		elsif @checked
			[]
		else
			check_https
		end
	end

	def check_https
		@checked = true
		@feed_url.gsub!(/http/, 'https')
		discover_rss
	end

	def valid_feed_url?
		Feedbag.feed? @feed_url
	end

end