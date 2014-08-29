namespace :articles do
  desc "Sanitize all article content"
  task validate_content: :environment do
  	articles = Article.all
  	articles.each do |article|
  		next if article.body.nil? || article.title == 'The channel specified in your RSS feed does not exist.'
  		sanitized_article = Scrubber::Article.new(article)
  		output = sanitized_article.validate
  		Article.update(article.id, title: output.title, body: output.body)
  	end
  end

end
