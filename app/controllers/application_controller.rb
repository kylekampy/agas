class ApplicationController < ActionController::Base
  before_filter :require_login
  protect_from_forgery
  helper_method :current_login
  helper_method :current_login_type
  helper_method :current_user
  helper_method :is_admin
  helper_method :is_phys
  helper_method :is_medstaff
  helper_method :is_at_least_phys
  helper_method :is_at_least_medstaff

  KEYS = []
  KEYS << "bf4e28785ab0560951dd0766f8059c4a" #pharmacy key
  KEYS << "98b84a80080b49716cdf31b29e11dbb4" #emr key
  KEYS << "b4628fe4f5f38e5b293be2024ce95239" #insurance key

  def valid_xml_request_with_key?
    key = params[:key]
    format = params[:format]
    return KEYS.include?(key) && format == "xml"
  end
  
  def current_login
     logger.debug "The object is #{session[:login_id]}"
    @current_login ||= Login.find(session[:login_id]) if session[:login_id]
  end
  
  def current_login_type
    unless session[:login_id].nil?
      puts "current_login.owner_type = #{current_login.owner_type}"
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

  ###################################
  # Some shorthand helper methods to
  # use. is_admin is considered the
  # top of the totem pole. Then it's
  # is_phys, followed by the lowly
  # medstaff.
  ###################################
  def is_admin
    current_login_type == "Administrator"
  end

  def is_phys
    current_login_type == "Physician"
  end

  def is_medstaff
    current_login_type == "Medical Staff" || current_login_type == "MedicalStaff"
  end

  def is_at_least_phys
    is_phys || is_admin
  end

  def is_at_least_medstaff
    is_medstaff || is_phys || is_admin
  end

  protected

  def authorize_administrator
    unless is_admin || valid_xml_request_with_key?
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end
  def authorize_physician
    unless is_physician || valid_xml_request_with_key?
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end
  def authorize_medical_staff
    unless is_medstaff || valid_xml_request_with_key?
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end
  def require_login
    unless current_login_type != nil || valid_xml_request_with_key?
      flash[:error] = "You are not authorized to view this area"
      redirect_to log_in_path
    end
  end

end
