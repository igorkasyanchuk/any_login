module AnyLogin
  module Provider
    module Authlogic

      module Controller

        def self.any_login_current_user_method(klass)
          @@any_login_current_user_method ||= "current_#{klass.to_s.parameterize.underscore}".to_sym
        end

        def any_login_sign_in
          reset_session
          @loginable = AnyLogin.klass.find(user_id)
          Object.const_get("#{AnyLogin.klass}Session").create(@loginable)
          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end

      end

    end
  end
end
