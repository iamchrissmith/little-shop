Rails.application.routes.draw do
  root to: 'items#index'

  get '/login', to: 'sessions#new'

  resources :users, only: [:new,:create]

  resources :items, only: [:index, :show]
  resources :categories, only: [:show]
end
