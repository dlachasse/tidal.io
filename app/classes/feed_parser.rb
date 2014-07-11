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
			@feed_url = feed_url
			fetch(@feed_url)
			load_feed(@feed_url)
			parse_entries
		end

		def parse_entries
			if @feedjira.is_a? Fixnum
				Rails.logger.warn "Unable to find feed at: #{@feed_url}"
				@feed.update!(active: false)
				return "Invalid feed"
			else
				@feed.update(active: true) unless @feed.active == true
				@feedjira.entries.map { |article|	check_and_save_article article }
				set_feed_update
			end
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

		def scrub_feed feed_url
			@feedjira = @feedjira.values.first if @feedjira.is_a? Hash
			scrub = Scrubber::Feed.new(@feedjira)
			@feedjira = scrub.validate
		end

		def retrieve_feed_data feed_url
			fetch(feed_url)
			scrub_feed(feed_url)
			data = Hash.new
			data[:name]  = @feedjira.title
			data[:url] 	 = @feedjira.url
			return data
		end

		def validate_passed_url feed_url
			feeds = []
      url = RSSValidation.new(feed_url)
      if url.valid_feed_url?
      	feeds << feed_url
      else
      	url.discover_rss.map { |url| feeds << url }.flatten
      end
      return_data feeds
    end

    def return_data feed
    	if feed.count > 1 || feed.empty?
        feed
      else
      	create_feed feed
      end
    end

    def create_feed feed
    	feed = feed.flatten(depth(feed)) if feed.is_a? Array
    	Feed.where(feed_url: feed.first).first_or_create(feed_url: feed.first)
    end

    def depth array
		  return 0 unless array.is_a?(Array)
		  return 1 + depth(array[0])
		end

	end

end