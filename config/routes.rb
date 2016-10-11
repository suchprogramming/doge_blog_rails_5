Rails.application.routes.draw do
  devise_for :users
  # Site root
  root to: "static#show", page: "index"

  # Static routes
  get "/:page" => "static#show"
end
