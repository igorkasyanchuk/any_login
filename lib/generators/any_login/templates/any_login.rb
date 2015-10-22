AnyLogin.setup do |config|
  # # provider (:devise, :authlogic, sorcery, clearance). Provider can be identified automatically based on your Gemfile
  # config.provider = nil

  # # enabled or not
  # config.enabled = Rails.env.to_s == 'development'

  # # Account, User, Person, etc
  # config.klass_name = 'User'

  #  # .all, .active, .admins, .groped_collection, etc ... need to return an array (or hash with arrays) of users
  # config.collection_method = :all

  # # to format user name in dropdown list
  # config.name_method = proc { |e| [e.email, e.id] }

  # # after logging in redirect user to path
  # config.redirect_path_after_login = :root_path

  # # login on select change event OR click on button, or BOTH
  # config.login_on = :both

  # # position of any_login box top_left, top_right, bottom_left, bottom_right
  # config.position = :bottom_left

  # # label on Login button
  # config.login_button_label = 'Login'

  # # prompt message in select
  # config.select_prompt = "Select #{AnyLogin.klass_name}"

  # # show any_login box by default
  # config.auto_show = false

  # # limit, integer or :none
  # config.limit = 10

  # # Enable http basic authentication
  # config.http_basic_authentication_enabled = false

  # # Enable http basic authentication
  # config.http_basic_authentication_user_name = 'any_login'

  # # Enable http basic authentication
  # config.ttp_basic_authentication_password = 'password'
end
