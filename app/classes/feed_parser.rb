class FeedParser
	# Note that @feed always relates to ActiveRecord
	# copy of the Feed object. @feedjira will relate
	# to a Feedjira object

	class << self

		def fetch feed_url
			@feedjira = Feedjira::Feed.fetch_and_parse(feed_url)
		end

		def load_feed feed_url
			@feed = Feed.find_by(feed_url: feed_url)
		end

		def retrieve_entries feed_url
			fetch(feed_url)
			load_feed(feed_url)
			@feedjira.entries.map { |article|	check_and_save_article article }
			set_feed_update
		end

		def set_feed_update
			@feed.update!(last_checked: Time.now)
		end

		def check_and_save_article article
			article = scrub_article article
			Article.where(permalink: article.url).first_or_create!(
				title: article.title,
				permalink: article.url,
				body: article.content || article.summary,
				published: article.published,
				feed_id: @feed.id)
		end

		def scrub_article article
			scrub = Scrubber::Article.new(article)
			scrub.validate
		end

		def scrub_feed
			scrub = Scrubber::Feed.new(@feedjira)
			@feedjira = scrub.validate
		end

		def retrieve_feed_data feed_url
			fetch(feed_url)
			scrub_feed
			data = Hash.new
			data[:name]  = @feedjira.title
			data[:url] 	 = @feedjira.url
			return data
		end

		def discover_rss feed_url
			if Feedbag.feed? feed_url
				[feed_url]
			else
				check_https feed_url
			end
		end

		def check_https feed_url
			feed = Feedbag.find feed_url
			if feed.empty?
				discover_rss(feed_url.gsub!(/http/, 'https'))
			else
				[feed]
			end
		end

	end

end