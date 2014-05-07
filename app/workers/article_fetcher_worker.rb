class ArticleFetcherWorker
  include Sidekiq::Worker

  def perform(feed_url)
    FeedParser.retrieve_entries(feed_url)
  end
end