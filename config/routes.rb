Rails.application.routes.draw do
  root "questions#index"
  get "/login", to: "auth#new"
  post "/login", to: "auth#create"
  delete "/logout", to: "auth#destroy"
  get "/feeds", to: "questions#index"
  scope "admin" do
    get "/index", to: "admin#index"
    get "/management", to: "admin#management"
    resources :categories, only: [:index, :create, :update, :destroy]
  end
  get "/signup", to: "users#new"
  get "/profile", to: "users#show"
  get "/setting", to: "users#setting"
  get "/edit", to: "users#edit"
  get "/recover-password", to: "password_resets#new"
  get "/change-password", to: "password_resets#edit"
  get "/confirm-email", to: "password_resets#confirm_email"
  post "/switch", to: "users#switch_mode"
  resources :users
  resources :questions do
    member do
      put "like", to: "actions#like"
      put "dislike", to: "actions#dislike"
      put "approve", to: "admin#approve"
      put "close", to: "admin#close"
      resources :comments, only: [:create, :update, :destroy]
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
