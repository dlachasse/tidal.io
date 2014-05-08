set :output, File.expand_path('./log/cron_log.log')

every 10.minutes do
  runner "Feed.requiring_update.pluck(:url) { |url| ArticleFetcherWorker.perform_async(url) }"
end