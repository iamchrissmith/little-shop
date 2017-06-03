Rails.application.routes.draw do
  root to: 'items#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'

  resources :users, only: [:new,:create]

  resources :items, only: [:index, :show]
  resources :categories, only: [:show]

  namespace :admin do
    get '/dashboard', to: 'users#show'
  end
end
