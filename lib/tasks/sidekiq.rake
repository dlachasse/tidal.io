desc 'Start daemonized Sidekiq process'
task :sidekiq do
	`sidekiq -d -L log/sidekiq.log -q mailer,5 -q default -e development`
end
