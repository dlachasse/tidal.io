# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "MyText"
    permalink "MyText"
    body "MyText"
    published "2014-05-03 09:53:31"
    is_read false
    feed_id 1
  end
end
