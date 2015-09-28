module AnyLogin
  module Strategy
    module Authlogic

      module Controller

        def self.any_login_current_user_method
          :current_user
        end

        def any_login_sign_in
          @loginable = AnyLogin.klass.find(params[:selected_id].presence || params[:id])
          UserSession.create(@loginable)
          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end

      end

    end
  end
end

AnyLogin.strategy = AnyLogin::Strategy::Authlogic