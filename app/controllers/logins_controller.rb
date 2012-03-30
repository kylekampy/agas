class LoginsController < ApplicationController
  skip_before_filter :require_login, :all
  
  def new
    @login = Login.new
  end
  
  def create
    @login = Login.new(params[:user])
    if @login.save
      redirect_to root_path, :notice => "Signed up!"
    else
      render "new"
    end
  end 
  
end
