class Physician < ActiveRecord::Base
 has_one :login, :as => :owner
 has_many :address, :as => :owner
 has_many :phones, :as => :owner
 has_many :emails, :as => :owner
end
