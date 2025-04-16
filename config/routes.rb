Rails.application.routes.draw do
  # Root route
  root "home#index"

  # Devise routes for authentication
  devise_for :users

  # Admin namespace with admin layout
  namespace :admin do
    # Admin dashboard
    root "dashboard", to: "dashboard#index"

    # Admin resources
    resources :contestants
    resources :episodes
    resources :users, only: [ :index, :show, :edit, :update ]
  end

  # User routes with user layout
  scope module: :user do
    # User dashboard
    get "dashboard", to: "dashboard#index"

    # User resources
    resources :votes, only: [ :new, :create ]
    resources :final_predictions, only: [ :new, :create ]
  end

  # Public routes (no layout)
  get "about", to: "home#about"
  get "rules", to: "home#rules"
  get "contact", to: "home#contact"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check
end
