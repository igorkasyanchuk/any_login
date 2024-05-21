require 'any_login/engine'

module AnyLogin
  extend ActiveSupport::Autoload

  autoload :Helpers

  module Provider
    autoload :Devise,    'any_login/providers/devise'
    autoload :Authlogic, 'any_login/providers/authlogic'
    autoload :Clearance, 'any_login/providers/clearance'
    autoload :Sorcery,   'any_login/providers/sorcery'
  end

  # enable in development mode only
  mattr_accessor :enabled
  @@enabled = Rails.env.to_s == 'development'

  # current provider, depends on auth gem
  mattr_accessor :provider
  @@provider = nil

  # Account, User, Person, etc
  mattr_accessor :klass_name
  @@klass_name = 'User'

  # Sign-in Method
  mattr_accessor :sign_in
  @@sign_in = nil

  # .all, .active, .admins, .groped_collection, etc ... need to return an array (or hash with arrays) of users
  mattr_accessor :collection_method
  @@collection_method = :all

  # to format user name in dropdown list
  mattr_accessor :name_method
  @@name_method = proc { |e| [e.email, e.id] }

  # after logging in redirect user to path
  mattr_accessor :redirect_path_after_login
  @@redirect_path_after_login = :root_path

  # login on select change event OR click on button, or BOTH
  mattr_accessor :login_on
  @@login_on = :both

  # position of any_login box top_left, top_right, bottom_left, bottom_right
  mattr_accessor :position
  @@position = :bottom_left

  # label on Login button
  mattr_accessor :login_button_label
  @@login_button_label = 'Login'

  # show any_login box by default
  mattr_accessor :auto_show
  @@auto_show = false

  # limit, integer or :none
  mattr_accessor :limit
  @@limit = 10

  # Previous limit, integer or :none
  mattr_accessor :previous_limit
  @@previous_limit = 6

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_enabled
  @@http_basic_authentication_enabled = false

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_user_name
  @@http_basic_authentication_user_name = 'any_login'

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_password
  @@http_basic_authentication_password = 'password'

  # Use controller proc condition
  mattr_accessor :verify_access_proc
  @@verify_access_proc = proc { |controller| true }

  def self.setup
    yield(self)
  end

  def self.collection(klass)
    Collection.new(collection_raw(klass))
  end

  def self.klasses
    @@klasses = if AnyLogin.klass_name.is_a?(Array)
                  AnyLogin.klass_name.map(&:constantize)
                else
                  [AnyLogin.klass_name.constantize]
                end
  end

  def self.cookie_name
    module_parent_name = if Rails::VERSION::MAJOR >= 6
                           Rails.application.class.module_parent_name
                         else
                           Rails.application.class.parent_name
                         end
    "any_login_previous_#{module_parent_name}".underscore
  end

  private

  def self.format_collection_raw(result)
    if result.is_a?(Hash) || (Object.const_defined?("OrderedHash") && result.is_a?(OrderedHash))
      result.to_a
    else
      result
    end
  end

  def self.collection_raw(klass)
    @@collection_raw = begin
      result = klass.send(AnyLogin.collection_method)
      if limit == :none
        format_collection_raw(result)
      else
        if result.is_a?(ActiveRecord::Relation)
          format_collection_raw(result.limit(limit))
        else
          format_collection_raw(result.take(limit))
        end
      end
    end
  end

end

require 'any_login/collection'
require 'any_login/engine'
require 'any_login/routes'
require 'any_login/version'
