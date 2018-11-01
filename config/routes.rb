Rails.application.routes.draw do
  root to: "welcome#index"

  resources :deals, only: [:show, :index]

  resources :places, only: [:show, :index]
end
