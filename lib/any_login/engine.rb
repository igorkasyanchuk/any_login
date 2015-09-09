module AnyLogin
  class Engine < ::Rails::Engine
    isolate_namespace AnyLogin

    initializer "any_login.assets_precompile", :group => :all do |app|
      app.config.assets.precompile += AnyLogin.assets
    end

    initializer "any_login.helpers" do
      if Object.const_defined?("Devise")
        require "any_login/strategy/devise"
      else
        throw "Unidentified auth gem..."
      end

      ActiveSupport.on_load(:action_controller) do
        AnyLogin::ApplicationController.send :include, AnyLogin.strategy::Controller
      end

      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, AnyLogin::ApplicationHelper
      end
    end

  end
end
