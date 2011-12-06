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
  end
  #helper_method :current_user
  
  def broadcast(channel, data)
    message = {:channel => channel, :data => data}
    puts message
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end

