module AnyLogin
  module ApplicationHelper
    extend ActiveSupport::Concern

    if AnyLogin.enabled

      def any_login_here
        if AnyLogin.enabled
          render 'any_login/any_login'
        end
      end

      def loginable_select
        collection = AnyLogin.collection
        select_options =
                        if AnyLogin.grouped?
                          grouped_options_for_select(collection)
                        else
                          options_for_select(collection)
                        end
        select_tag :loginable_id, select_options, loginable_select_html_options
      end

      def loginable_select_html_options
        options = {}
        #options = { :include_blank => true }
        options[:onchange] = 'AnyLogin.on_select_change();' if AnyLogin.login_on == :both
        options[:prompt] = AnyLogin.select_prompt
        options
      end

      def any_login_klasses
        klasses = []
        klasses << "any_login_#{AnyLogin.position || 'bottom_left'}"
        klasses << 'any_login_auto_show' if AnyLogin.auto_show
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
