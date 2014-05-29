class FaviconFetcherWorker
  include Sidekiq::Worker

	def perform(id)
		Favicon.new(id)
	end

end