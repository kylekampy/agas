class ApplicationController < ActionController::Base
  before_filter :authorize_administrator
  before_filter :authorize_physician
  before_filter :authorize
  protect_from_forgery
  helper_method :current_login
  helper_method :current_login_type
  helper_method :current_user


  def current_login
     logger.debug "The object is #{session[:login_id]}"
    @current_login ||= Login.find(session[:login_id]) if session[:login_id]
  end
  
  def current_login_type
    unless session[:login_id].nil?
      current_login.owner_type 
    end
  end
  
  def current_user
    if current_login
     if current_login_type == "Physician"
       return Physician.find(current_login.owner_id);
     elsif current_login_type == "Administrator"
       return Administrator.find(current_login.owner_id);
     else
       #
     end 
    end
  end
  protected 

  def authorize_administrator
    if current_login_type == "Administrator"
      redirect_to log_in_path
    end
  end
  def authorize_physician
    if current_login_type == "Physician"
      redirect_to log_in_path
    end
  end
  def authorize
    if session[:login_id].nil?
      redirect_to log_in_path
    end
  end

end
