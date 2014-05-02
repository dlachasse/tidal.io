require 'faker'

FactoryGirl.define do
  factory :user do
  	name                   { Faker::Name.first_name }
  	email                  { Faker::Internet.email }
  	password               'secret'
  	password_confirmation  'secret'

    factory :invalid_user do
      email ''
    end

  end
end
