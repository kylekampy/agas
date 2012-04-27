class Patient < ActiveRecord::Base
  has_one :emergancy_contact
  has_many :addresses, :as => :owner, :dependent => :destroy
  has_many :phones, :as => :owner, :dependent => :destroy
  has_many :emails, :as => :owner, :dependent => :destroy
  has_many :appointments, :foreign_key => 'pat_id'
  validates_presence_of :firstname
  validates_presence_of :lastname
  accepts_nested_attributes_for :addresses, :allow_destroy => true
  accepts_nested_attributes_for :phones, :allow_destroy => true
  accepts_nested_attributes_for :emails, :allow_destroy => true
  accepts_nested_attributes_for :emergancy_contact
  attr_accessible :emergancy_contact_attributes # the format is the child_class followed by the "_attributes"
  attr_accessible :primary_phy_id, :insurance_id, :middlename, :lastname, :second_physician_id, :firstname, :date_of_birth, :pharmacy_id #For some reason these were all protected when attempting to seed. I have no idea why, but this fixed it.
end
