class Patient < ActiveRecord::Base
  has_many :addresses, :as => :owner
  has_many :phones, :as => :owner
  has_many :emails, :as => :owner
end
