class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user_session = UserSession.new params.require(:user)
      .permit(:login, :password)
    if @user_session.save
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_path
  end
end
