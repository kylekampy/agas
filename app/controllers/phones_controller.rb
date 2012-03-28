class PhonesController < ApplicationController
  skip_before_filter :authorize_administrator, :all
  skip_before_filter :authorize_physician, :all

 def new
  @phone = Phone.new
 end 

 def create
   @phone = Phone.new(params[:phone])
   if @phone.save
   else
     render "new"
   end
 end

end

