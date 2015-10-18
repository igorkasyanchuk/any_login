module AnyLogin
  module Provider
    module Devise

      module Controller

        def self.any_login_current_user_method
          @@any_login_current_user_method ||= "current_#{AnyLogin.klass.to_s.underscore}".to_sym
        end

        def any_login_sign_in
          @loginable = AnyLogin.klass.find(params[:selected_id].presence || params[:id])
          sign_in AnyLogin.klass.to_s.underscore.to_sym, @loginable
          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end

      end

    end
  end
end

AnyLogin.provider = AnyLogin::Provider::Devise