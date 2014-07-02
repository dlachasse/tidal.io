class OPMLParser

	attr_reader :user_id

	def initialize user_id
		@file_path = File.expand_path("public/opml/#{user_id}.xml")
		@file_contents = Nokogiri::XML(File.open(@file_path).read)
		@user = user_id
		parse
		cleanup
	end

	def parse
		@urls = @file_contents.xpath("//@xmlUrl").map { |node| node.to_str }
		subscribe
	end

	def subscribe
		@urls.each do |url|
			feed = FeedParser.validate_passed_url(url)
			if feed.is_a? Feed
				Subscription.create_subscription(@user, feed.id)
			end
		end
	end

	def cleanup
		File.delete(@file_path)
	end

end