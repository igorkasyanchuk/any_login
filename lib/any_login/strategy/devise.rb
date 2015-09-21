module AnyLogin
  module Strategy
    module Devise

      module Controller

        def any_login_sign_in
          @loginable = AnyLogin.klass.find(params[:selected_id].presence || params[:id])
          sign_in AnyLogin.klass.to_s.underscore.to_sym, @loginable
          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end

      end

    end
  end
end

AnyLogin.strategy = AnyLogin::Strategy::Devise