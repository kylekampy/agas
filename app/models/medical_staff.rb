class MedicalStaff < ActiveRecord::Base
  has_one :login, :as => :owner
  has_one :physician
  has_many :phones, :as => :owner, :dependent => :destroy
  has_many :emails, :as => :owner, :dependent => :destroy
  validates_presence_of :firstname
  validates_presence_of :lastname

  accepts_nested_attributes_for :phones, :allow_destroy => true
  accepts_nested_attributes_for :login, :allow_destroy => true
  accepts_nested_attributes_for :emails, :allow_destroy => true

end
