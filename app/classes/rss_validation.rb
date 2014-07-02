class RSSValidation

	def initialize feed_url
		@feed_url = feed_url
		@checked = false
	end

	def discover_rss
		if Feedbag.feed? @feed_url
			[@feed_url]
		elsif @checked
			[]
		else
			check_https
		end
	end

	def check_https
		@checked = true
		feed = Feedbag.find @feed_url
		if feed.empty?
			@feed_url.gsub!(/http/, 'https')
			discover_rss
		else
			[feed]
		end
	end

	def valid?
		Feedbag.feed? @feed_url
	end

end