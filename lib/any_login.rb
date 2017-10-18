require 'any_login/engine'

module AnyLogin

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

  # prompt message in select
  mattr_accessor :select_prompt
  @@select_prompt = "Select #{AnyLogin.klass_name}"

  # show any_login box by default
  mattr_accessor :auto_show
  @@auto_show = false

  # limit, integer or :none
  mattr_accessor :limit
  @@limit = 10

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

  def self.grouped?
    collection_type == :grouped
  end

  def self.collection
    collection_raw.collect do |e|
      if grouped?
        [e[0], e[1].collect(&name_method)]
      else
        if name_method.is_a?(Symbol)
          e.send(name_method)
        else
          name_method.call(e)
        end
      end
    end
  end

  def self.klass
    @@klass = AnyLogin.klass_name.constantize
  end

  private

  def self.format_collection_raw(result)
    if result.is_a?(Hash) || (Object.const_defined?("OrderedHash") && result.is_a?(OrderedHash))
      result.to_a
    else
      result
    end
  end

  def self.collection_raw
    @@collection_raw = begin
      result = AnyLogin.klass.send(AnyLogin.collection_method)
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

  def self.collection_type
    @@collection_type =
                        if collection_raw[1].is_a?(Array)
                          :grouped
                        else
                          :single
                        end
    @@collection_type
  end

end

require 'any_login/engine'
require 'any_login/routes'
require 'any_login/version'
