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
			scrub = Scrubber.new(article)
			scrub.validate_article
		end

		def scrub_feed
			scrub = Scrubber.new(@feedjira)
			scrub.validate_feed
		end

		def retrieve_feed_data feed_url
			fetch(feed_url)
			data = Hash.new
			data[:name]  = scrub_feed
			data[:url] 	 = find_url
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

		def find_url
			if @feedjira.url
				@feedjira.url
			elsif @feedjira.feed_url =~ /feeds.feedburner.com/
				find_main_url_from_feedburner
			else
				logger.info "Feed URL is empty, XML feed found at: #{@feedjira.feed_url}"
			end
		end

		def find_main_url_from_feedburner
			page = Nokogiri::XML.parse(open(@feedjira.feed_url))
			namespace = set_namespace page
			page.xpath('//xmlns:link/@href', namespace).first.value
		end

		def set_namespace doc
			ns = doc.namespaces.first[0]
			v = doc.namespaces.first[1]
			{ns => v}
		end

	end

end