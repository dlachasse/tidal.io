require 'faker'

FactoryGirl.define do
  factory :feed do
    name 	{ Faker::Lorem.words(num = 7).join(" ") }
    url 	"https://github.com/blog/drinkup.atom"
    last_checked Time.now

    factory :feed_with_articles do
	    ignore do
	      articles_count 5
	    end

	    after(:create) do |feed, evaluator|
	      create_list(:article, evaluator.articles_count, feed: feed)
	    end
	  end
  end
end
