Rails.application.routes.draw do

  # Static routes
  get "/content/:page" => "static#show"

  # Site root
  root to: "posts#index"

  # SuperAdmin routes
  namespace :superadmins do
    resources :invitations, only: [:index, :new, :create]
  end

  # Devise Admin routes
  devise_for :admins

  # Admin routes for Posts
  resources :admins, only: [:show] do
    resources :posts, except: [:index]
  end

  # Administration routes
  namespace :administration do
    resources :users, only: [:edit, :update]
    resources :admins, only: [:index, :edit, :update]
    
    get '/sign_up/:token', to: 'registrations#new'
    post '/registrations', to: 'registrations#create'

    get '/dashboard', to: 'dashboard#index'
  end

  # Devise user routes
  devise_for :users

  # User routes for Posts
  resources :users, only: [:show] do
    resources :posts, except: [:index]
  end

end
