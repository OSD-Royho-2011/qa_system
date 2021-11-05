Rails.application.routes.draw do
  root "auth#signin"

  get "/signin", to: "auth#signin"
  get "/signup", to: "auth#signup"
  get "/feeds", to: "questions#index"
  get "/detail", to: "questions#detail"
  scope "admin" do
    get "/index", to: "admin#index"
    get "/management", to: "admin#management"
  end
  get "user/profile"
  get "user/edit"
end
