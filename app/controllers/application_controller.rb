class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_login
  load_and_authorize_resource
  
  private
  
    def current_user
      @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
    end
    
    def check_login
      unless current_user
        flash.now[:notice] = 'Please login first' 
        redirect_to root_path
      end
    end
    
    helper_method :current_user
end