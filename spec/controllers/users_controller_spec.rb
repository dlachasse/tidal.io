require 'spec_helper'

describe UsersController do

	describe 'GET#new' do

		before :each do
			get :new
		end

		it 'renders new template' do
			expect(response).to render_template :new
		end

		it 'uses correct named route' do
			expect(signup_path).to eq '/signup'
		end

	end

	describe 'POST#create' do

		it 'saves new user' do
			expect {
				post :create, user: attributes_for(:user)
			}.to change(User, :count).by(1)
		end

	end

end