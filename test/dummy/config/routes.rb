Rails.application.routes.draw do
  devise_for :users
  mount AnyLogin::Engine => "/any_login"

  root to: "home#index"

  get '/about' => 'home#about'
end
