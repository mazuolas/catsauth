class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if user
      user.reset_session_token!
      user.save
      session[:sessions_token] = user.sessions_token
      redirect_to root_url
    else
      flash[:errors] = ['Loggin failed you loser!']
      redirect_to new_sessions_url
    end
  end

  def destroy
    current_user.sessions_token = nil
    session[:sessions_token] = nil
    redirect_to new_sessions_url
  end
end
