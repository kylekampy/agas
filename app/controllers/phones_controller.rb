class PhonesController < ApplicationController
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

