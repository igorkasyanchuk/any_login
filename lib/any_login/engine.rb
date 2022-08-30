module AnyLogin
  class Engine < ::Rails::Engine
    isolate_namespace AnyLogin

    initializer 'any_login.helpers' do
      load_provider
      ActiveSupport.on_load :action_controller do
        AnyLogin.provider.constantize::Controller.send :include, Rails.application.routes.url_helpers
      end

      ActiveSupport.on_load :action_view do
        include AnyLogin::Helpers
      end
    end

    private

    def load_provider
      if (selected_provider = AnyLogin.provider || provider)
        provider_with_module = "AnyLogin::Provider::#{selected_provider.to_s.capitalize}"
        if Object.const_defined?(provider_with_module)
          AnyLogin.provider = provider_with_module
        else
          AnyLogin.provider = selected_provider.to_s
        end
      else
        throw 'Please use this gem with Devise, Authlogic or Clearance or provide a custom handler class'
      end
    end

    def provider
      if AnyLogin.provider.nil?
        if Object.const_defined?('Authlogic')
          :authlogic
        elsif Object.const_defined?('Devise')
          :devise
        elsif Object.const_defined?('Clearance')
          :clearance
        elsif Object.const_defined?('Sorcery')
          :sorcery
        end
      end
    end

  end
end
