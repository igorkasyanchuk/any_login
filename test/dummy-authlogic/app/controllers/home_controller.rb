class HomeController < ApplicationController
  before_action :require_user, :only => [:about]

  def index
  end

  def about
  end
end
