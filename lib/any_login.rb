require "any_login/engine"

module AnyLogin

  module Helpers
    autoload :ViewHelper, 'any_login/helpers/view_helper'
  end

  module Hooks
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

  def self.setup
    yield(self)
  end

  def self.collection
    AnyLogin.loginable_klass.send(AnyLogin.loginable_collection_method)
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

end

require 'any_login/engine'
require 'any_login/version'
