AnyLogin.setup do |config|
  config.enabled = true # enabled or not
  config.klass_name = 'User' # Account, User, Person, etc
  config.collection_method = :all   # .all, .active, .admins, .groped_collection, etc ... need to return an array (or hash with arrays) of users
  config.name_method = proc { |e| [format(e), e.id] } # to format user name in dropdown list
  config.redirect_path_after_login = :root_path  # after logging in redirect user to path
  config.login_on = :both # login on select change event OR click on button, or BOTH
  config.position = :bottom_left # position of any_login box top_left, top_right, bottom_left, bottom_right
  config.login_button_label = 'Login' # label on Login button
  config.select_prompt = "Select #{AnyLogin.klass_name}" # prompt message in select
  config.current_user_method = :current_user # method to return current_user logged in
  config.auto_show = false  # show any_login box by default
end
