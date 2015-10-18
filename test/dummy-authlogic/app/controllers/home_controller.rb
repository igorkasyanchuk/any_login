class HomeController < ApplicationController
  before_filter :require_user, :only => [:about]

  def index
  end

  def about
  end
end
