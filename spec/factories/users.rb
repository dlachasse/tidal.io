require 'faker'

FactoryGirl.define do
  factory :user do
  	name                   { Faker::Name.first_name }
  	email                  { Faker::Internet.email }
    password               { Faker::Internet.password }
    api_key                SecureRandom.base64.tr('+/=', 'Qrt')

    factory :user_with_subscriptions do
      ignore do
        subscriptions_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:subscription, evaluator.subscriptions_count, user: user)
      end
    end

    factory :invalid_user do
      email ''
    end

  end
end
