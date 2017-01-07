Rails.application.routes.draw do

  # Static routes
  get "/content/:page" => "static#show"

  # Site root
  root to: "posts#index"

  # SuperAdmin routes
  scope "superadmin/manage", as: "superadmin_manage" do
    resources :admins, only: [:edit, :update]
  end

  scope "superadmin", as: "superadmin" do
    resources :invitations, only: [:index, :new, :create]
  end

  # Admin sign up routes
  get '/admins/sign_up/:token', to: 'admins#new'
  post '/admins/create', to: 'admins#create'

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
    resources :users, only: [:edit, :update]
  end

  # Devise user routes
  devise_for :users

  # User routes for Posts
  resources :users, only: [:show] do
    resources :posts, except: [:index]
  end

end
