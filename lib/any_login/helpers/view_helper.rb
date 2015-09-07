module AnyLogin

  module Helpers

    module ViewHelper
      extend ActiveSupport::Concern

      def any_login_here
        render 'any_login/any_login'
      end
    end

  end

end