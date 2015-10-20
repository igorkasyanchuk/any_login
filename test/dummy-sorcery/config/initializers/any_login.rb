AnyLogin.setup do |config|
  config.provider = :sorcery
  config.login_button_label = 'Sign in with Sorcery'
  config.klass_name = 'User'
  config.collection_method = :all
end
