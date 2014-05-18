require 'sidekiq/web'
Rails.application.routes.draw do

  scope 'api' do
    resources :users, except: [:index] do
      member do
        get :activate
      end
      get 'feeds', to: 'subscriptions#index'
    end

    get 'login', to: 'sessions#new', as: :login
    resources :sessions, except: [:index, :edit, :update, :new]

    resources :feeds, except: [:index, :edit, :update] do
      get 'articles', to: 'articles#index'
    end

    get 'article/:id', to: 'articles#show'
  end

  mount Sidekiq::Web => '/sidekiq'

  root 'users#new'
end
