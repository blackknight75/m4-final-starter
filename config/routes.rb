Rails.application.routes.draw do
  root to: "links#index"

  get 'signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :links, only: [:index]
  resources :users, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
