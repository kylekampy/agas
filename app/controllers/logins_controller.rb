class LoginsController < ApplicationController
def new
  @login = Login.new
end

def create
  @login = Login.new(params[:user])
  if @login.save
    redirect_to root_url, :notice => "Signed up!"
  else
    render "new"
  end
end 

end
