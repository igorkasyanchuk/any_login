Rails.application.routes.draw do
  devise_for :users
  devise_for :staffs
  root to: "home#index"

  get '/about' => 'home#about'
end
