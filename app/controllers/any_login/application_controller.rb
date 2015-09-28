module AnyLogin
  class ApplicationController < ActionController::Base

    if AnyLogin.enabled

      if AnyLogin.http_basic_authentication_enabled
        http_basic_authenticate_with :name => AnyLogin.http_basic_authentication_user_name,
                                     :password => AnyLogin.http_basic_authentication_password
      end


      def any_login
        AnyLogin.strategy::Controller.instance_method(:any_login_sign_in).bind(self).call
      end
    end

  end
end
