require 'spec_helper'

describe SessionsController do
  let(:user) { create(:user) }

  context 'GET#new' do

    it 'renders new template' do
      get :new
      expect(response).to be_success
    end

  end

  # NO PROPER WAY TO CURRENTLY TEST SPECIFIC RESPONSE CODES
  # context 'POST#create' do
    # it '200 success with proper login' do
    #   expect {
    #     post :create, session: { email: user.email, password: user.password }
    #   }.response_status.to eq '200'
    # end

    # it '401 error with incorrect credentials' do
    #   expect {
    #     post :create, session: { email: 'wrong', password: 'nope' }
    #   }.response_status.to eq '401'
    # end
  # end

  context 'DELETE#destroy' do

    before :each do
      login_user(user)
    end

    it 'returns http success' do
      expect {
        delete :destroy, id: user
      }.to be_success
    end
  end

end
