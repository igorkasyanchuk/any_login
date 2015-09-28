Rails.application.routes.draw do
  resource :user_session, only: [:create, :new, :destroy]

  root to: "home#index"

  get '/about' => 'home#about'
end
