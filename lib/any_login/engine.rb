module AnyLogin
  class Engine < ::Rails::Engine
    isolate_namespace AnyLogin

    initializer 'any_login.assets_precompile', :group => :all do |app|
      app.config.assets.precompile += ['any_login/person.png']
    end

    initializer 'any_login.helpers' do
      load_provider

      ActiveSupport.on_load :action_controller do
        if Rails::VERSION::MAJOR >= 6
          AnyLogin.provider::Controller.send :include, Rails.application.routes.url_helpers
        end
      end

      ActiveSupport.on_load :action_view do
        include AnyLogin::Helpers
      end
    end

    private

    def load_provider
      case AnyLogin.provider || provider
      when :authlogic
        require 'any_login/providers/authlogic'
      when :devise
        require 'any_login/providers/devise'
      when :clearance
        require 'any_login/providers/clearance'
      when :sorcery
        require 'any_login/providers/sorcery'
      else
        throw 'Please use this gem with any of the following gems: Devise, Authlogic or Clearance'
      end
    end

    def provider
      if AnyLogin.provider.nil? && Object.const_defined?('Authlogic')
        :authlogic
      elsif AnyLogin.provider.nil? && Object.const_defined?('Devise')
        :devise
      elsif AnyLogin.provider.nil? && Object.const_defined?('Clearance')
        :clearance
      elsif AnyLogin.provider.nil? && Object.const_defined?('Sorcery')
        :sorcery
      end
    end

  end
end
