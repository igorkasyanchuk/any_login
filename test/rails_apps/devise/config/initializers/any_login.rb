AnyLogin.setup do |config|
  config.enabled = true
  config.provider = :devise
  config.login_button_label = 'Sign in with Devise'
  config.klass_names = ['User', 'Staff']
  config.collection_method = :all
end
