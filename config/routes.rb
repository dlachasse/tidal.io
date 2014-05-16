require 'sidekiq/web'
Rails.application.routes.draw do

  get 'signup', to: 'users#new', as: :signup
  post 'signup', to: 'users#create'
  resources :users, except: [:index, :new, :create] do
    member do
      get :activate
    end
  end

  get 'login', to: 'sessions#new', as: :login
  resources :sessions, except: [:index, :edit, :update, :new]

  resources :feeds, except: [:index, :edit, :update] do
    get 'articles', to: 'articles#index'
  end

  get 'article/:id', to: 'articles#show'

  mount Sidekiq::Web => '/sidekiq'

  root 'users#new'
end
