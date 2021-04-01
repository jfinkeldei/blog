Rails.application.routes.draw do
  root "articles#index"

  get "/articles", to: "articles#index"
  #get "/articles/:id", to: "articles#show"
  resources :articles do
    resources :comments
  end

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  get "/account", to: "users#show", as: "account"

  resources :users
  resources :sessions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
