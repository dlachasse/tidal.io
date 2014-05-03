require 'faker'

FactoryGirl.define do
  factory :feed do
    name 	{ Faker::Lorem.words(num = 7).join(" ") }
    url 	{ Faker::Internet.url }

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
