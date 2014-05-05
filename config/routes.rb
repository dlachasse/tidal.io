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

  resources :feeds, except: [:index, :edit, :update]

  root 'users#new'
end
