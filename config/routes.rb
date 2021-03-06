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

  resources :sessions, only: [:create, :destroy]
  get 'login', to: 'sessions#new', as: :login

  mount Sidekiq::Web => '/sidekiq'

  root 'api/v1/users#new'
end
