class EmergencyContact < ActiveRecord::Base
  has_one :phone, :as => :owner
  has_one :address, :as => :owner
  belongs_to :patient
  
  accepts_nested_attributes_for :phone
  attr_accessible :phone_attributes # the format is the child_class followed by the "_attributes"
  attr_accessible :name, :address, :phone
end
