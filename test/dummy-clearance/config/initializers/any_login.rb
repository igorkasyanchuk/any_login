AnyLogin.setup do |config|
  config.provider = :clearance
  config.login_button_label = 'Sign in with Clearance'
  config.klass_name = 'User'
  config.collection_method = :all
end
