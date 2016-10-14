Rails.application.routes.draw do
  devise_for :users

  # Site root
  root to: "posts#index"

  # Static routes
  get "/:page" => "static#show"

  # Post CRUD
  resources :users do
    resources :posts, only: [:create, :update, :edit, :destroy, :new]
  end

  # Public posts
  resources :posts, only: [:index, :show]
end
