require "any_login/engine"

module AnyLogin

  module Helpers
    autoload :ViewHelper, 'any_login/helpers/view_helper'
  end

  module Hooks
    autoload :AuthsDevise, 'any_login/auths/devise'
  end

  mattr_accessor :assets
  @@assets = nil

  mattr_accessor :auth_gem
  @@auth_gem = nil

  def self.setup
    yield self
  end

  def self.assets
    @@assets ||= ['any_login/init.js', 'any_login/init.css']
  end

end

require 'any_login/engine'
require 'any_login/version'
