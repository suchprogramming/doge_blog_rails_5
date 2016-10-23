Rails.application.routes.draw do

  # Static routes
  get "/:page" => "static#show"

  # Site root
  root to: "posts#index"

  # Devise admin routes
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    passwords: "admins/passwords"
  }

  resources :admins, only: [:show] do
    resources :posts
  end

  # Devise user routes
  devise_for :users

  # User Posts routes
  resources :users, only: [:show] do
    resources :posts
  end

  # Admin routes for user management
  scope "admin" do
    resources :users, only: [:index, :edit, :update, :destroy]
  end

end
