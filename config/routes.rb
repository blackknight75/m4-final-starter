Rails.application.routes.draw do
  root to: "links#index"

  get 'signup', to: 'users#new', as: 'signup'
  get '/login', to: 'users#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :links, only: [:index, :edit, :update]
  resources :users, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update, :create]
    end
  end
end
