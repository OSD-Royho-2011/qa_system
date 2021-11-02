Rails.application.routes.draw do
  root "auth#signin"

  get "/signin", to: "auth#signin"
  get "/signup", to: "auth#signup"
end
