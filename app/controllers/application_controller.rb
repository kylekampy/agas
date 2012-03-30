class ApplicationController < ActionController::Base
  before_filter :require_login
  protect_from_forgery
  helper_method :current_login
  helper_method :current_login_type
  helper_method :current_user

  KEYS = []
  KEYS << "bf4e28785ab0560951dd0766f8059c4a" #pharmacy key
  KEYS << "98b84a80080b49716cdf31b29e11dbb4" #emr key
  KEYS << "b4628fe4f5f38e5b293be2024ce95239" #insurance key

  def valid_xml_request_with_key?
    key = params[:key]
    puts "key = #{key}"
    format = params[:format]
    puts "format = #{format}"
    puts "valid key and xml = #{KEYS.include?(key) && format == "xml"}"
    return KEYS.include?(key) && format == "xml"
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
     end 
    end
  end
  protected 

  def authorize_administrator
    puts "authorize_administrator".center(80, "-=")
    unless current_login_type == "Administrator" || valid_xml_request_with_key?
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end
  def authorize_physician
    puts "authorize_physician".center(80, "-=")
    unless current_login_type == "Physician" || valid_xml_request_with_key?
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end
  def require_login
    puts "require login".center(80, "-=")
    puts "current_login_type = #{current_login_type}"
    unless current_login_type != nil || valid_xml_request_with_key?
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end

end
