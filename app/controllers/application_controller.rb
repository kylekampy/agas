class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user


  def current_user
     logger.debug "The object is #{session[:login_id]}"
    @current_user ||= Login.find(session[:login_id]) if session[:login_id]
  end
end
