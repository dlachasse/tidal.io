require 'sidekiq/web'
Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, except: [:index] do
        member do
          get :activate
        end
        get 'feeds', to: 'subscriptions#index'
      end

      resources :feeds, except: [:edit, :update] do
        get 'articles', to: 'articles#index'
      end

      get 'article/:id', to: 'articles#show', as: 'article'
      post 'opml/create'
    end
  end

  post 'sessions', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy', as: :logout
  get 'login', to: 'sessions#new', as: :login
  get 'signup', to: 'api/v1/users#new', as: :signup

  mount Sidekiq::Web => '/sidekiq'

  root 'pages#home'
end
