require 'spec_helper'

describe FeedsController do

	describe 'GET#new' do

		before :each do
			get :new
		end

		it 'renders new template' do
			expect(response).to render_template :new
		end

	end

	describe 'POST#create' do

		it 'creates new feed' do
			expect {
				post :create, feed: { url: 'http://www.site.com' }
			}.to change(Feed, :count).by(1)
		end

	end

end