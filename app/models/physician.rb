class Physician < ActiveRecord::Base
 has_one :login, :as => :owner
 has_many :addresses, :as => :owner
 has_many :phones, :as => :owner
 has_many :emails, :as => :owner
 validates_presence_of :firstname 
 validates_presence_of :lastname
 accepts_nested_attributes_for :login, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
 accepts_nested_attributes_for :addresses, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true 
 accepts_nested_attributes_for :phones, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true 
 accepts_nested_attributes_for :emails, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

end
