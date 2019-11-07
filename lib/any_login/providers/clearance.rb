module AnyLogin
  module Provider
    module Clearance

      module Controller

        def self.any_login_current_user_method
          @@any_login_current_user_method ||= "current_#{AnyLogin.klass.to_s.parameterize.underscore}".to_sym
        end

        def any_login_sign_in
          reset_session
          @loginable = AnyLogin.klass.find(user_id)
          sign_in @loginable
          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end

      end

    end
  end
end

AnyLogin.provider = AnyLogin::Provider::Clearance

AnyLogin::ApplicationController.send(:include, ::Clearance::Controller)
