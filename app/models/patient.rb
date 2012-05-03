class Patient < ActiveRecord::Base
  has_one :emergency_contact
  has_many :addresses, :as => :owner, :dependent => :destroy
  has_many :phones, :as => :owner, :dependent => :destroy
  has_many :emails, :as => :owner, :dependent => :destroy
  has_many :appointments, :foreign_key => 'pat_id'
  validates_presence_of :firstname, :lastname, :primary_phy_id, :gender, :date_of_birth, :emergency_contact, :pharmacy_id, :insurance_id

  accepts_nested_attributes_for :addresses, :allow_destroy => true
  accepts_nested_attributes_for :phones, :allow_destroy => true
  accepts_nested_attributes_for :emails, :allow_destroy => true
  accepts_nested_attributes_for :emergency_contact, :allow_destroy => true
  attr_accessible :emergency_contact_attributes # the format is the child_class followed by the "_attributes"
  attr_accessible :primary_phy_id, :insurance_id, :middlename, :lastname, :second_physician_id, :firstname, :date_of_birth, :pharmacy_id #For some reason these were all protected when attempting to seed. I have no idea why, but this fixed it.
end
