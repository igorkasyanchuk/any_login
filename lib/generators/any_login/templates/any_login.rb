AnyLogin.setup do |config|
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

  # # method to return current_user logged in
  # config.current_user_method = :current_user

  # # show any_login box by default
  # config.auto_show = false

  # # limit, integer or :none
  # mattr_accessor :limit
  # @@limit = 10
end
