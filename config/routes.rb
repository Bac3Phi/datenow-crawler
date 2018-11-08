Rails.application.routes.draw do
  root to: "welcome#index"
  resources :users
  resources :celebrations

  resources :deals, only: [:show, :index]

  resources :places, only: [:show, :index]
end
