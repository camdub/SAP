class ApplicationController < ActionController::Base
  protect_from_forgery
  
  force_ssl
  
  before_filter :authenticate, :except => [:login, :signup]

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]   
  end
  def authenticate 
    redirect_to user_login if not current_user
  end
  #helper_method :current_user
end
