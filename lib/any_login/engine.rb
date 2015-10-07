module AnyLogin
  class Engine < ::Rails::Engine
    isolate_namespace AnyLogin

    initializer 'any_login.assets_precompile', :group => :all do |app|
      app.config.assets.precompile += ['any_login/person.png']
    end

    initializer 'any_login.helpers' do
      load_provider

      ActiveSupport.on_load :action_controller do
        AnyLogin::ApplicationController.send :include, AnyLogin.provider::Controller
      end

      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, AnyLogin::ApplicationHelper
      end
    end

    def load_provider
      if (AnyLogin.provider.nil? && Object.const_defined?('Authlogic')) || AnyLogin.provider == :authlogic
        require 'any_login/providers/authlogic'
      elsif (AnyLogin.provider.nil? && Object.const_defined?('Devise')) || AnyLogin.provider == :devise
        require 'any_login/providers/devise'
      elsif (AnyLogin.provider.nil? && Object.const_defined?('Clearance')) || AnyLogin.provider == :clearance
        require 'any_login/providers/clearance'
      else
        throw 'Please use this gem with any of the following gems: Devise, Authlogic or Clearance'
      end
    end

  end
end
