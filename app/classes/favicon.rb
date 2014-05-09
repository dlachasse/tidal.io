class Favicon

	attr_reader :id, :url

	def initialize(id, url)
		@feed = Feed.find(id)
		@url = url
		fetch
	end

	def fetch
		@url = url
		fav = Flavicon.find(url)
		set_to_feed fav
	end

	def set_to_feed favicon
		@feed.update(favicon: favicon)
	end

end