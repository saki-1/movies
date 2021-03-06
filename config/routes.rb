Rails.application.routes.draw do

  root to: 'movies#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] do
    member do
      get :likes
    end
  end
  
  resources :movies
  resources :youtubes, only: [:index]
  resources :favorites, only: [:create, :destroy]

end
