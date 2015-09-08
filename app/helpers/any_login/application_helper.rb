module AnyLogin
  module ApplicationHelper

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

    def any_login_position
      "any_login_#{AnyLogin.position || 'bottom_left'}"
    end

  end
end
