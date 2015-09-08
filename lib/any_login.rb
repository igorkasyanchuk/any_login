require "any_login/engine"

module AnyLogin

  module Helpers
    autoload :ViewHelper, 'any_login/helpers/view_helper'
  end

  module Hooks
    autoload :Devise, 'any_login/strategy/devise'
  end

  mattr_accessor :strategy
  @@strategy = nil

  mattr_accessor :assets
  @@assets = nil

  mattr_accessor :loginable_klass_name
  @@loginable_klass_name = "User"

  mattr_accessor :loginable_collection_method
  @@loginable_collection_method = :all

  mattr_accessor :loginable_name_method
  @@loginable_name_method = -> (e) { [e.email, e.id] }

  mattr_accessor :redirect_path_after_login
  @@redirect_path_after_login = :root_path

  mattr_accessor :login_on
  @@login_on = :both

  mattr_accessor :position
  @@position = :top_right # top_left, top_right, bottom_left, bottom_right

  def self.setup
    yield self
  end

  def self.collection
    AnyLogin.loginable_klass.send(AnyLogin.loginable_collection_method)
  end

  def self.loginable_klass
    @@loginable_klass ||= AnyLogin.loginable_klass_name.constantize
  end

  def self.assets
    @@assets ||= ['any_login/init.js', 'any_login/init.css']
  end

end

require 'any_login/engine'
require 'any_login/version'
