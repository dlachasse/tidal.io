require 'spec_helper'

describe FeedsController do
	let(:user) { create(:user) }

	describe 'GET#new' do

		before :each do
			login_user(user)
			get :new
		end

		it 'renders new template' do
			expect(response).to render_template :new
		end

	end

	describe 'POST#create' do

		before :each do
			login_user(user)
		end

		it 'creates new feed' do
			expect {
				session[:user_id] = 1
				post :create, feed: { url: 'https://github.com/blog/drinkup.atom' }
			}.to change(Feed, :count).by(1)
		end

		it 'subscribes user after creating' do
			expect {
				session[:user_id] = 1
				post :create, feed: { url: 'https://github.com/blog/drinkup.atom' }
			}.to change(Subscription, :count).by(1)
		end

	end

end