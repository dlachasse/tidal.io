require 'spec_helper'

describe SessionsController do
  let(:user) { create(:user) }

  context 'GET#new' do

    it 'renders new template' do
      get :new
      expect(response).to be_success
    end

  end

end
