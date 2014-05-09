class FaviconFetcherWorker
  include Sidekiq::Worker

	def perform(id, url)
		Favicon.new(id, url)
	end

end