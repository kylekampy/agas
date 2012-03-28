class SessionsController < ApplicationController
  skip_before_filter :authorize_administrator, :all
  skip_before_filter :authorize_physician, :all
  skip_before_filter :authorize, :all

  def new
  end

  def create
    login = Login.authenticate(params[:username], params[:password])
    if login
      session[:login_id] = login.id
       logger.debug "The login is #{login.id}"
       logger.debug "Session is #{session[:login_id]}"
      redirect_to root_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    session[:login_id] = nil
    redirect_to log_in_path, :notice => "Logged out!"
  end
end
