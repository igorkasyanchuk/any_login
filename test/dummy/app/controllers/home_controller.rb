class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:about]

  def index
  end

  def about
  end
end
