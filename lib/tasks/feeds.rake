namespace :feeds do
  desc "Updates feed articles"
  task pull: :environment do
  	Feed.update_feeds
  end

end
