Rails.application.routes.draw do

  # Static routes
  get "/content/:page" => "static#show"

  # Site root
  root to: "posts#index"

  # Devise Admin routes
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    passwords: "admins/passwords"
  }

  # Admin routes for Posts
  resources :admins, only: [:index, :show] do
    resources :posts, except: [:index]
  end

  # Admin routes for user management
  scope "admins/manage", as: "admin_manage" do
    resources :users, only: [:edit, :update, :destroy]
  end

  # Devise user routes
  devise_for :users

  # User routes for Posts
  resources :users, only: [:show] do
    resources :posts, except: [:index]
  end

end
