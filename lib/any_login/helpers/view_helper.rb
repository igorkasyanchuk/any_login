module AnyLogin

  module Helpers

    module ViewHelper
      extend ActiveSupport::Concern

      def any_login_here
        if AnyLogin.enabled
          render 'any_login/any_login'
        end
      end

      def loginable_select
        select_options = AnyLogin.collection.collect(&AnyLogin.loginable_name_method)
        options = {}
        #options = { :include_blank => true }
        if AnyLogin.login_on == :both
          options[:onchange] = 'AnyLogin.on_select_change();'
        end
        options[:prompt] = AnyLogin.select_prompt
        select_tag :loginable_id, options_for_select(select_options), options
      end

      def any_login_klasses
        klasses = []
        klasses << "any_login_#{AnyLogin.position || 'bottom_left'}"
        if AnyLogin.auto_show
          klasses << 'any_login_auto_show'
        end
        klasses.join(' ')
      end

      def current_user_information
        if respond_to?(AnyLogin.current_user_method) && user = send(AnyLogin.current_user_method)
          content_tag :span, :class => 'any_login_user_information' do
            raw("Current #{AnyLogin.loginable_klass_name}: #{h(AnyLogin.format_loginable(user))} &mdash; ID: #{user.id}")
          end
        end
      end

    end

  end

end