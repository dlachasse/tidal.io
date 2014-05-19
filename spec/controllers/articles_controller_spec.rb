require 'spec_helper'

describe ArticlesController do

  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:article) { create(:article) }

  describe 'GET#index' do
    before :each do
      login_user(user)
      get :index, feed_id: feed, format: :json
    end

    it 'returns http success' do
      expect(response).to be_success
    end

  end

  describe 'GET#show' do

    before :each do
      login_user(user)
      get :show, id: article, format: :json
    end

    it 'returns http success for logged in user' do
      expect(response).to be_success
    end

  end

end
