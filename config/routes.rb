Rails.application.routes.draw do
  devise_for :users, controllers: {
                       sessions: "api/sessions",
                       registrations: "api/registrations",
                     }
  namespace :api do
    resources :problems
    resources :services
    devise_scope :user do
      post "/sign_in", :to => "sessions#create"
      post "/sign_up", :to => "registrations#create"
      delete "/sign_out", :to => "sessions#destroy"
    end
  end

  root to: "welcome#index"
  resources :users
  resources :celebrations

  resources :deals, only: [:show, :index]

  resources :places, only: [:show, :index]
end
