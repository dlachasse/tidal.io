require 'spec_helper'

describe Api::V1::UsersController do
	let(:user) { create(:user) }

	describe 'GET#new' do

		before :each do
			login_user(user)
			get :new
		end

		it 'renders new template' do
			expect(response).to render_template :new
		end

		it 'uses correct named route' do
			expect(new_api_user_path).to eq '/api/users/new'
		end

	end

	describe 'POST#create' do

		before :each do
			login_user(user)
		end

		it 'saves new user' do
			expect {
				post :create, user: attributes_for(:user)
			}.to change(User, :count).by(1)
		end

	end

	describe 'GET#show' do

		before :each do
			preset_authenticated_request(user)
			get :show, id: user, format: :json
		end

		it 'returns http success' do
			expect(response).to be_success
		end
	end

end