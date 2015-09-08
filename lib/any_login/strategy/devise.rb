module AnyLogin
  module Strategy
    module Devise

      module Controller

        def any_login_sign_in
          @loginable = AnyLogin.loginable_klass.find(params[:loginable_id].presence || params[:id])
          sign_in @loginable
          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end

      end

    end
  end
end

puts 'Devise stratedy loaded ...'

AnyLogin.strategy = AnyLogin::Strategy::Devise