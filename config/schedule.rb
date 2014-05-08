set :output, File.expand_path('./log/cron_log.log')

every 10.minutes do
  runner "Feed.update_feeds"
end