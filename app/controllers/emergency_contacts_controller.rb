class EmergencyContactsController < ApplicationController
  
 def new
  @emergency_contact = EmergencyContact.new
  @emergency_contact.build_address
  @emergency_contact.build_phone
 end 

 def create
   @emergency_contact = EmergencyContact.new(params[:emergency_contact])
   if @emergency_contact.save
   else
     render "new"
   end
 end
end