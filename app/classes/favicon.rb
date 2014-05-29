class Favicon

	attr_reader :id, :url

	def initialize(id)
		@feed = Feed.find(id)
		fetch
	end

	def fetch
		fav = Flavicon.find(@feed.url)
		set_to_feed fav unless fav.nil?
	end

	def set_to_feed favicon
		@feed.update!(favicon: favicon)
	end

end