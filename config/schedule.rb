set :output, File.expand_path('./log/cron_log.log')

every 10.minutes do
  runner "Feed.update_feeds"
end

every 1.day do
	runner "Feed.update_favicons"
end