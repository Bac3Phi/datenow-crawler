Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
  end

  root to: "welcome#index"
  resources :users
  resources :celebrations

  resources :deals, only: [:show, :index]

  resources :places, only: [:show, :index]
end
