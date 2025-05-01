Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    confirmations: "users/confirmations"
  }

  # Root route
  root "drafts#index"

  # resources :drafts

  # Drafts routes
  resources :drafts do
    resources :contestants
    resources :episodes, only: [ :show, :update ]
    resources :votes, only: [ :new, :create, :update ]
    resources :final_predictions, only: [ :new, :create ]
    member do
      get :send_invites
      post :send_invites
    end
  end

  # Contestants routes
  # resources :contestants, only: [ :index, :show ]

  # # Users routes
  # resources :users, only: [ :show ] do
  #   member do
  #     get :drafts
  #     get :votes
  #   end
  # end



  # Public routes (no layout)
  get "rules", to: "home#rules"
  get "contact", to: "home#contact"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check
end
