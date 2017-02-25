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
  devise_for :admins, skip: [:registrations]
  as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    put 'admins' => 'devise/registrations#update', :as => 'admin_registration'
  end

  # Admin routes for Posts
  resources :admins, only: [:show] do
    resources :posts, except: [:index] do
      resources :comments, except: [:index]
    end
  end

  # Administration routes
  namespace :administration do
    resources :users, only: [:edit, :update]
    resources :admins, only: [:index, :edit, :update]

    get '/sign_up/:token', to: 'registrations#new'
    post '/registrations', to: 'registrations#create'

    resources :comments, only: [:update]

    get '/dashboard', to: 'dashboard#index'
  end

  # Devise user routes
  devise_for :users

  # User routes for Posts
  resources :users, only: [:show] do
    resources :posts, except: [:index] do
      resources :comments, except: [:index]
    end
  end

  # Markdown processing
  resource :markdown_preview, only: [:create]

  # Voting
  resource :votes, only: [:create]

end
