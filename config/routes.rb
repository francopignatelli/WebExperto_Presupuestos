Rails.application.routes.draw do
  devise_for :users, registrations: 'users/sessions/registrations'
  # Defines the root path route ("/")
  root "home#index"
end
