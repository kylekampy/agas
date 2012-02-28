class Patient < ActiveRecord::Base
  has_many :addresses, :as => :owner
  has_many :phones, :as => :owner
  has_many :emails, :as => :owner
  validates_presence_of :firstname
  validates_presence_of :lastname
  accepts_nested_attributes_for :addresses, :allow_destroy => true
  accepts_nested_attributes_for :phones, :allow_destroy => true
  accepts_nested_attributes_for :emails, :allow_destroy => true
end
