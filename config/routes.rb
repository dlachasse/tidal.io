Rails.application.routes.draw do

  get 'signup', to: 'users#new', as: :signup
  post 'signup', to: 'users#create'
  resources :users, except: [:index, :new, :create] do
    member do
      get :activate
    end
  end

  resources :sessions, except: [:index, :edit, :update]

  root 'users#new'
end
