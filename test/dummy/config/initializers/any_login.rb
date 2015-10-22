AnyLogin.setup do |config|
  config.provider = :devise
  config.login_button_label = 'Sign in with Devise'
  config.klass_name = 'User'
  config.collection_method = :all
end
