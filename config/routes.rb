Rails.application.routes.draw do
  root to: "deals#index"

  resources :deals, only: %w(show index)
  # resources :deals
end
