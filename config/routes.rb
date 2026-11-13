AnyLogin::Engine.routes.draw do
  post '/any_login/sign_in' => 'application#any_login', as: :sign_in
  get '/any_login/search' => 'application#search', as: :search
end

Rails.application.routes.draw do
  mount_routes
end
