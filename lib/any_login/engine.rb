module AnyLogin
  class Engine < ::Rails::Engine
    isolate_namespace AnyLogin

    initializer "any_login.assets_precompile", :group => :all do |app|
      app.config.assets.precompile += AnyLogin.assets
    end

    initializer "any_login.helpers" do
      ActiveSupport.on_load(:action_controller) do
        #ActionController::Base.send :include, Ckeditor::Helpers::Controllers
      end

      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, AnyLogin::Helpers::ViewHelper
      end
    end

    initializer "any_login.hooks" do
      if Object.const_defined?("Devise")
        require "any_login/auths/devise"
      end
    end
  end
end
