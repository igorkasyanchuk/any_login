module AnyLogin
  class ApplicationController < ActionController::Base
    protect_from_forgery except: :js
    before_action :try_not_to_leak_any_login_is_installed

    include AnyLogin.provider.constantize::Controller
    include ::Clearance::Controller if AnyLogin.provider.eql?("AnyLogin::Provider::Clearance")

    if AnyLogin.enabled
      if AnyLogin.http_basic_authentication_enabled
        http_basic_authenticate_with :name => AnyLogin.http_basic_authentication_user_name,
                                     :password => AnyLogin.http_basic_authentication_password
      end
    end

    def any_login
      head 403 && return unless AnyLogin.verify_access_proc.call(self)
      add_to_previous
      AnyLogin.provider.constantize::Controller.instance_method(:any_login_sign_in).bind(self).call
    end

    def css
      send_file AnyLogin::Engine.root.join('app', 'assets', 'stylesheets', 'any_login', 'application.css'), content_type: 'text/css'
    end

    def js
      send_file AnyLogin::Engine.root.join('app', 'assets', 'javascripts', 'any_login', 'application.js'), content_type: 'text/javascript'
    end

    private

    def try_not_to_leak_any_login_is_installed
      try_to_render_404_not_found unless AnyLogin.enabled
    end

    def try_to_render_404_not_found
      raise ActiveRecord::RecordNotFound
    end

    def user_id
      params[:back_to_previous_id].presence || params[:selected_id].presence || params[:id]
    end

    def klass
      params[:as].constantize
    end

    def previous
      cookies[AnyLogin.cookie_name] ||= ""
    end

    def previous_list
      previous.split(',').take(AnyLogin.previous_limit)
    end

    def add_to_previous
      cookies[AnyLogin.cookie_name] = ([user_id] + previous_list).uniq.join(',')
    end

  end
end
