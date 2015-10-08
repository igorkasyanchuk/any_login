class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :log_user

  private
  def log_user
    if current_user
      logger.info "==> #{current_user.email}"
    else
      logger.info "==> No USER"
    end
  end
end
