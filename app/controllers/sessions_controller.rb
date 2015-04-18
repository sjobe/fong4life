class SessionsController < ApplicationController
  skip_before_action :check_login
  skip_load_and_authorize_resource
  
  def create
    user = User.from_omniauth(env["omniauth.auth"])
  rescue => error
    flash[:error] = "You don't have access to the system."
  else
    session[:user_id] = user.id
  ensure   
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end