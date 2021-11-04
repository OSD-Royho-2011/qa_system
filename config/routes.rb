Rails.application.routes.draw do
  root "auth#signin"

  get "/signin", to: "auth#signin"
  get "/signup", to: "auth#signup"
  get "/feeds", to: "questions#index"
  get "/detail", to: "questions#detail"
end
