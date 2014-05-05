require 'spec_helper'

describe SessionsController do
  let(:user) { create(:user) }

  context 'GET#new' do

    it 'renders new template' do
      get :new
      expect(response).to be_success
    end

  end

  context 'POST#create' do
    # it 'returns http success' do
    #   expect {
    #     post :create, session: attributes_for(:user)
    #     }.(response).to be_success
    # end

    # it 'rerenders new template on unsuccessful login' do
    #   expect {
    #     post :create, session: attributes_for(:user, password: 'super password')
    #   }.to render_template :new
    # end
  end

end
