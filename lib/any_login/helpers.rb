module AnyLogin
  module Helpers
    extend ActiveSupport::Concern

    def any_login_here
      render 'any_login/any_login' if AnyLogin.enabled && AnyLogin.verify_access_proc.call(self.controller)
    end

    if AnyLogin.enabled

      def any_login_id_input
        text_field_tag :id, '', :placeholder => 'ID', :class => 'any_login_id_input', :required => true
      end

      def any_login_submit
        submit_tag AnyLogin.login_button_label
      end

      def any_login_select(klass)
        collection = AnyLogin.collection(klass)
        select_options =
                        if collection.grouped?
                          grouped_options_for_select(collection.to_a)
                        else
                          options_for_select(collection.to_a)
                        end
        select_tag 'selected_id', select_options, select_html_options(klass).merge(id: nil)
      end

      def any_login_previous_select(klass)
        ids = any_login_previous_ids
        return if ids.blank?

        users = ids.collect do |id|
          klass.where(klass.primary_key => id).first
        end.compact

        collection = AnyLogin::Collection.new(users).to_a
        if collection.any?
          select_options = options_for_select(collection)
          [
            content_tag(:span, class: 'anylogin_back_to_user') do
              "History: "
            end,
            select_tag(:back_to_previous_id, select_options, select_html_options("Back to:"))
          ].join.html_safe
        end
      end

      def any_login_previous_ids
        (cookies[AnyLogin.cookie_name].presence || '').split(',').take(AnyLogin.previous_limit)
      end

      def select_html_options(klass)
        prompt = "Select #{klass}"
        options = {}
        options[:prompt] = prompt
        options
      end

      def any_login_klasses
        klasses = []
        klasses << "any_login_#{AnyLogin.position || 'bottom_left'}"
        klasses.join(' ')
      end

      def current_user_information(klass)
        if respond_to?(AnyLogin.provider.constantize::Controller.any_login_current_user_method(klass)) &&
           user = send(AnyLogin.provider.constantize::Controller.any_login_current_user_method(klass))
          content_tag :span, :class => 'any_login_user_information' do
            if AnyLogin.name_method.is_a?(Symbol)
              raw("Current #{klass.to_s}: #{h(user.send(AnyLogin.name_method)[0])} &mdash; ID: #{user.id}")
            else
              raw("Current #{klass.to_s}: #{h(AnyLogin.name_method.call(user)[0])} &mdash; ID: #{user.id}")
            end
          end
        end
      end
    end
  end
end
