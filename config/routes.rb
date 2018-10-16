Rails.application.routes.draw do
  get 'items/new'

  get 'rankings/follower'

  get 'favorites/create'

  get 'favorites/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup' , to: 'users#new'
  resources :users, only:[:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :favorites
    end
    collection do
      get :search
    end
  end
  
  resources :posts
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :items, only: [:new]
end
