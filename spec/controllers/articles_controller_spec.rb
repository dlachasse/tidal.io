require 'spec_helper'

describe ArticlesController do

  let(:feed) { create(:feed) }
  let(:article) { create(:article) }

  describe 'GET#index' do
    before :each do
      get :index, feed_id: feed, format: :json
    end

    it 'returns http success' do
      expect(response).to be_success
    end

  end

  describe 'GET#show' do

    before :each do
      get :show, id: article, format: :json
    end

    it 'returns http success' do
      expect(response).to be_success
    end

  end

end
