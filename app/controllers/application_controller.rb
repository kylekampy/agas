class ApplicationController < ActionController::Base
  before_filter :authorize_administrator
  before_filter :authorize_physician
  before_filter :authorize
  protect_from_forgery
  helper_method :current_login
  helper_method :current_login_type
  helper_method :current_user
  helper_method :valid_key?

  KEYS = []
  KEYS << "bf4e28785ab0560951dd0766f8059c4a" #pharmacy key
  KEYS << "98b84a80080b49716cdf31b29e11dbb4" #emr key
  KEYS << "b4628fe4f5f38e5b293be2024ce95239" #insurance key

  def valid_key?
    puts "in valid_key?".center(100, "*")
    puts "params = #{params}"
    puts "key = #{params[:key]}"
    return KEYS.include?(params[:key])
  end
  
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
       nil
     end 
    end
  end
  protected 

  def authorize_administrator
    if current_login_type == "Administrator"
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end
  def authorize_physician
    if current_login_type == "Physician"
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end
  def authorize
    if session[:login_id].nil?
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end

end
