class ApplicationController < ActionController::Base
  protect_from_forgery
  
  force_ssl
  
  before_filter :authenticate, :except => [:login, :signup]

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]   
  end
  def authenticate
    #puts current_user.netid 
    redirect_to user_login_path if not current_user
    puts "++++++++++++++++++++++++++++++++++++++++++#{@current_user.netid}++++++++++++++++++++++++++++++++++++++++++"
  end
  #helper_method :current_user
end
