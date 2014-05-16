require 'spec_helper'

describe ArticlesController do

  describe 'GET#index' do
    before :each do
      get :index
    end

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'renders correct template' do
      expect(response).to render_template :index
    end

  end

  describe 'GET#show' do

    before :each do
      get :show, id: 1
    end

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'renders correct template' do
      expect(response).to render_template :show
    end

  end

end
