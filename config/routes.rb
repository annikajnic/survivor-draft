Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    confirmations: "users/confirmations"
  }

  # Root route
  root "drafts#index"
  get "admin/test", to: "admin/test#index"
  get "admin/test/practice", to: "admin/test#practice"

  # Drafts routes
  resources :drafts do
    resources :episodes, only: [ :show, :update ]
    resources :votes, only: [ :create, :update ]
    member do
      get :send_invites
      post :send_invites
    end
  end

  # Contestants routes
  resources :contestants, only: [ :index, :show ]

  # Users routes
  resources :users, only: [ :show ] do
    member do
      get :drafts
      get :votes
    end
  end

  # Admin namespace with admin layout
  namespace :admin do
    # Admin dashboard
    root "dashboard", to: "dashboard#index"

    # Admin resources
    resources :contestants
    resources :drafts
    resources :users, only: [ :index, :show, :edit, :update ]
  end

  # User routes with user layout
  scope module: :player do
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
