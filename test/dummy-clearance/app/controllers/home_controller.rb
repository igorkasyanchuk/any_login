class HomeController < ApplicationController
  before_action :require_login, :only => [:about]

  def index
  end

  def about
  end
end
