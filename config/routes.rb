AnyLogin::Engine.routes.draw do
  post '/any_login/sign_in' => 'application#any_login', as: :sign_in
end

Rails.application.routes.draw do
  mount_routes
end
