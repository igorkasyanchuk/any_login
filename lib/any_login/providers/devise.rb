module AnyLogin
  module Provider
    module Devise

      module Controller

        DEFAULT_SIGN_IN = proc do |loginable|
          reset_session
          sign_in Controller.mapping_key, loginable
        end

        def self.any_login_current_user_method(klass)
          @@any_login_current_user_method ||= "current_#{mapping_key(klass)}".to_sym
        end

        def self.mapping_key(klass)
          @@mapping_key ||= ::Devise.mappings.detect {|_key, mapping| mapping.class_name == klass.name }.first
        end

        def any_login_sign_in
          @loginable = AnyLogin.klass.find(user_id)

          sign_in = AnyLogin.sign_in || DEFAULT_SIGN_IN
          instance_exec(@loginable, &sign_in)

          redirect_to main_app.send(AnyLogin.redirect_path_after_login)
        end
      end

    end
  end
end
