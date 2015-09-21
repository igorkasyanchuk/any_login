AnyLogin.setup do |config|
  config.login_button_label = 'Sign up'
  config.klass_name = 'User'
  config.collection_method = :groped_collection
end