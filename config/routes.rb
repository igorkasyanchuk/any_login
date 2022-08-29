AnyLogin::Engine.routes.draw do
  get '/any_login/js' => 'application#js', as: :js
  get '/any_login/css' => 'application#css', as: :css
  post '/any_login/sign_in' => 'application#any_login', as: :sign_in
end

Rails.application.routes.draw do
  mount_routes
end
