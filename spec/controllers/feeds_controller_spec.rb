require 'spec_helper'
Capybara.app_host = 'http://0.0.0.0:3000'

describe Api::V1::FeedsController do
	let(:feed) { create(:feed) }
	let(:user) { create(:user) }

	describe 'POST#create' do

		context 'logged in user' do

			before :each do
				preset_authenticated_request(user)
			end

			it 'creates new feed' do
				expect {
					post :create,
					{ feed: { url: 'https://github.com/blog/drinkup.atom' }, user_id: user.id }
				}.to change(Feed, :count).by(1)
			end

			it 'subscribes user after creating' do
				expect {
					post :create, feed: { url: 'https://github.com/blog/drinkup.atom' }, user_id: user.id
				}.to change(Subscription, :count).by(1)
			end

		end

		context 'logged out user' do

			it 'cannot create new feed' do
				expect {
					post :create, feed: { url: 'https://github.com/blog/drinkup.atom' }, user_id: nil
				}.to change(Feed, :count).by(0)
			end

		end

	end

	describe 'GET#show' do

		context 'for logged in user' do

			it 'shows feed of :id' do
				preset_authenticated_request(user)
				@response_object = { 'id' => feed.id, 'name' => feed.name, 'url' => feed.url }.to_json
				get :show, id: feed.id
				expect(response.body).to eq @response_object
			end

		end

	end

end