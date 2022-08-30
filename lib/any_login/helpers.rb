module AnyLogin
  module Helpers
    extend ActiveSupport::Concern

    def any_login_here
      render 'any_login/any_login' if AnyLogin.enabled && AnyLogin.verify_access_proc.call(self.controller)
    end

    if AnyLogin.enabled

      def any_login_id_input
        text_field_tag :id, '', :placeholder => 'ID', :id => 'any_login_id_input', :required => true
      end

      def any_login_submit
        submit_tag AnyLogin.login_button_label
      end

      def any_login_select
        collection = AnyLogin.collection
        select_options =
                        if collection.grouped?
                          grouped_options_for_select(collection.to_a)
                        else
                          options_for_select(collection.to_a)
                        end
        select_tag :selected_id, select_options, select_html_options
      end

      def any_login_previous_select
        ids = any_login_previous_ids
        return if ids.blank?

        users = ids.collect do |id|
          AnyLogin.klass.where(AnyLogin.klass.primary_key => id).first
        end.compact

        collection = AnyLogin::Collection.new(users).to_a
        if collection.any?
          select_options = options_for_select(collection)
          [
            content_tag(:span, id: 'anylogin_back_to_user') do
              "History: "
            end,
            select_tag(:back_to_previous_id, select_options, select_html_options("Back to:"))
          ].join.html_safe
        end
      end

      def any_login_previous_ids
        (cookies[AnyLogin.cookie_name].presence || '').split(',').take(AnyLogin.previous_limit)
      end

      def select_html_options(prompt = AnyLogin.select_prompt)
        options = {}
        options[:prompt] = prompt
        options
      end

      def any_login_klasses
        klasses = []
        klasses << "any_login_#{AnyLogin.position || 'bottom_left'}"
        klasses.join(' ')
      end

      def current_user_information
        if respond_to?(AnyLogin.provider.constantize::Controller.any_login_current_user_method) &&
           user = send(AnyLogin.provider.constantize::Controller.any_login_current_user_method)
          content_tag :span, :class => 'any_login_user_information' do
            if AnyLogin.name_method.is_a?(Symbol)
              raw("Current #{AnyLogin.klass_name}: #{h(user.send(AnyLogin.name_method)[0])} &mdash; ID: #{user.id}")
            else
              raw("Current #{AnyLogin.klass_name}: #{h(AnyLogin.name_method.call(user)[0])} &mdash; ID: #{user.id}")
            end
          end
        end
      end
    end
  end
end
