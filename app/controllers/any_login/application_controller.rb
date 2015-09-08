module AnyLogin
  class ApplicationController < ActionController::Base

    def any_login
      AnyLogin.strategy::Controller.instance_method(:any_login_sign_in).bind(self).call
    end

  end
end
