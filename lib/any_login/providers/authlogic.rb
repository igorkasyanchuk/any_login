module AnyLogin
  module Provider
    module Authlogic

      module Controller

        def self.any_login_current_user_method
          @@any_login_current_user_method ||= "current_#{AnyLogin.klass.to_s.underscore}".to_sym
        end

        def any_login_sign_in
          @loginable = AnyLogin.klass.find(params[:selected_id].presence || params[:id])
          Object.const_get("#{AnyLogin.klass}Session").create(@loginable)
          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end

      end

    end
  end
end

AnyLogin.provider = AnyLogin::Provider::Authlogic
