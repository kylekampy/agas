class SessionsController < ApplicationController
  def new
  end

  def create
    login = Login.authenticate(params[:username], params[:password])
    if user
      session[:login_id] = login.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    session[:login_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
