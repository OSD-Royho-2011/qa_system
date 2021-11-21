Rails.application.routes.draw do
  root "questions#index"
  get "/login", to: "auth#new"
  post "/login", to: "auth#create"
  delete "/logout", to: "auth#destroy"
  get "/feeds", to: "questions#index"
  scope "admin" do
    get "/index", to: "admin#index"
    get "/user-management", to: "admin#management"
    post "/edit-role", to: "admin#edit_user_role"
    resources :categories, only: [:index, :create, :update, :destroy]
  end
  get "/signup", to: "users#new"
  get "/profile", to: "users#show"
  get "/edit", to: "users#edit"
  get "/recover-password", to: "password_resets#new"
  get "/change-password", to: "password_resets#edit"
  get "/confirm-email", to: "password_resets#confirm_email"
  post "/switch", to: "users#switch_mode"
  resources :users
  resources :questions do
    member do
      put "like", to: "questions#like"
      put "dislike", to: "questions#dislike"
      put "approve", to: "questions#approve"
      put "close", to: "questions#close"
      resources :comments, only: [:create, :update, :destroy]
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :roles
  post "new-role-permission", to: "roles#create_permission_role"
  post "delete-permission", to: "roles#delete_role_permission"
  get "load-action", to: "roles#load_permission_actions"
  post "renew-password", to: "users#change_password"
  post "update-info", to: "users#update_basic_info"
  match '*path' => 'errors#error_404', via: :all
end
