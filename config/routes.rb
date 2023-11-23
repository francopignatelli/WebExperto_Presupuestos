Rails.application.routes.draw do
  devise_for :users, registrations: 'users/sessions/registrations'
  resources :users, only: [:edit, :update]
  resources :lineitems
  resources :products
  resources :budgets do
    resources :lineitems
  end
  resources :categories

  namespace :api do
    namespace :v1 do
      post '/login', to: 'authentication#login'
      resources :budgets
      # Additional routes can be defined here if needed
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
