require "any_login/engine"

module AnyLogin

  module Strategy
    autoload :Devise, 'any_login/strategy/devise'
  end

  mattr_accessor :enabled
  @@enabled = true

  mattr_accessor :strategy # current strategy, depends on auth gem
  @@strategy = nil

  mattr_accessor :assets # assets which we need to build for production
  @@assets = nil

  mattr_accessor :loginable_klass_name # Account, User, Person, etc
  @@loginable_klass_name = "User"

  mattr_accessor :loginable_collection_method # .all, .active, .admins, etc ... need to return an array of users
  @@loginable_collection_method = :all
  #@@loginable_collection_method = :groped_collection

  mattr_accessor :loginable_name_method # to format user name in dropdown list
  @@loginable_name_method = -> (e) { [format_loginable(e), e.id] }

  mattr_accessor :redirect_path_after_login # after logging in redirect user to path
  @@redirect_path_after_login = :root_path

  mattr_accessor :login_on # login on select change event OR click on button, or BOTH
  @@login_on = :both

  mattr_accessor :position
  @@position = :bottom_left # position of any_login box top_left, top_right, bottom_left, bottom_right

  mattr_accessor :login_button_label
  @@login_button_label = 'Login' # label on Login button

  mattr_accessor :select_prompt
  @@select_prompt = 'Select User' # prompt message in select

  mattr_accessor :current_user_method
  @@current_user_method = :current_user # method to return current_user logged in

  mattr_accessor :auto_show # show any_login box by default
  @@auto_show = false

  mattr_accessor :collection_limit
  @collection_limit = :none

  def self.setup
    yield(self)
  end

  def self.grouped?
    collection_type == :grouped
  end

  def self.collection
    collection_raw.collect do |e|
      if grouped?
        [e[0], e[1].collect(&loginable_name_method)]
      else
        loginable_name_method.call(e)
      end
    end
  end

  def self.loginable_klass
    @@loginable_klass ||= AnyLogin.loginable_klass_name.constantize
  end

  def self.assets
    @@assets ||= ['any_login/person.png']
  end

  def self.format_loginable(user)
    user.email
  end

  private

  def self.collection_raw
    @@collection_raw ||= AnyLogin.loginable_klass.send(AnyLogin.loginable_collection_method).to_a
  end

  def self.collection_type
    @@collection_type ||=
                          if collection_raw[1].is_a?(Array)
                            :grouped
                          else
                            :single
                          end
    @@collection_type
  end

end

require 'any_login/engine'
require 'any_login/version'
