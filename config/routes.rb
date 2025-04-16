Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  namespace :admin do
    resources :contestants
  end

  resources :users
  get "home/players"
  get "home/rules"
  get "login" => "devise/sessions#new"
  get "logout" => "devise/sessions#destroy"
  get "signup" => "devise/registrations#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check
end
