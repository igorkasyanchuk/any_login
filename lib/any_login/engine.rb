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
        puts "Unidentified auths gem..."
      end

      ActiveSupport.on_load(:action_controller) do
        puts "action_controller loaded ..."
        ActionController::Base.send :include, AnyLogin.strategy::Controller
        AnyLogin::ApplicationController.send :include, AnyLogin.strategy::Controller
      end

      ActiveSupport.on_load :action_view do
        puts "action_view loaded ..."
        ActionView::Base.send :include, AnyLogin::Helpers::ViewHelper
        ActionView::Base.send :include, AnyLogin::ApplicationHelper
      end
    end

    # initializer "any_login.hooks" do

    # end
  end
end
