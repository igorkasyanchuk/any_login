module AnyLogin
  module Provider
    module Sorcery

      module Controller

        def self.any_login_current_user_method(klass)
          @@any_login_current_user_method ||= "current_#{klass.to_s.parameterize.underscore}".to_sym
        end

        def any_login_sign_in
          reset_session
          @loginable = klass.find(user_id)
          auto_login @loginable
          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end

      end

    end
  end
end
