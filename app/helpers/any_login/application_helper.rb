module AnyLogin
  module ApplicationHelper

    def loginable_select
      select_options = AnyLogin.collection.collect(&AnyLogin.loginable_name_method)
      options = {}
      #options = { :include_blank => true }
      if AnyLogin.login_on == :both
        options[:onchange] = "jQuery(this).parents('form').submit()"
      end
      options[:prompt] = 'Select ...'
      select_tag :loginable_id, options_for_select(select_options), options
    end

    def any_login_position
      "any_login_#{AnyLogin.position || 'bottom_left'}"
    end

  end
end
