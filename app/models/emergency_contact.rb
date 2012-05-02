class EmergencyContact < ActiveRecord::Base
  has_one :phone, :as => :owner, :dependent => :destroy
  has_one :address, :as => :owner, :dependent => :destroy
  belongs_to :patient
  
  accepts_nested_attributes_for :phone, :allow_destroy => true
  accepts_nested_attributes_for :address, :allow_destroy => true
  attr_accessible :name
end
