require 'faker'

FactoryGirl.define do
  factory :article do
    title 		 { Faker::Lorem.words(num = 12).join(" ") }
    permalink  { Faker::Internet.url }
    body 		   { Faker::Lorem.paragraphs(paragraph_count = 4).join(" ") }
    published  Time.now
    feed

    factory :read_article do
    	is_read true
    end
  end
end
