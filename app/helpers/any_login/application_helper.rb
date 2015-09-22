module AnyLogin
  module ApplicationHelper
    extend ActiveSupport::Concern

    def any_login_here
      render 'any_login/any_login' if AnyLogin.enabled
    end

    if AnyLogin.enabled

      def any_login_id_input
        text_field_tag :id, '', :placeholder => 'ID', :id => 'any_login_id_input'
      end

      def any_login_submit
        submit_tag AnyLogin.login_button_label
      end

      def any_login_select
        collection = AnyLogin.collection
        select_options =
                        if AnyLogin.grouped?
                          grouped_options_for_select(collection)
                        else
                          options_for_select(collection)
                        end
        select_tag :selected_id, select_options, select_html_options
      end

      def select_html_options
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
        if respond_to?(AnyLogin.strategy::Controller.any_login_current_user_method) &&
           user = send(AnyLogin.strategy::Controller.any_login_current_user_method)
          content_tag :span, :class => 'any_login_user_information' do
            raw("Current #{AnyLogin.klass_name}: #{h(AnyLogin.name_method.call(user)[0])} &mdash; ID: #{user.id}")
          end
        end
      end

    end

  end
end
