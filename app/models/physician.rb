class Physician < ActiveRecord::Base
 has_one :login, :as => :owner
 has_many :address, :as => :owner
 has_many :phones, :as => :owner
 has_many :emails, :as => :owner

  def username
    "TODO - This logic shouldn't even be going through here, since login contains this information. Rails doesn't know how to access login from here. Only the other way around."
  end
end
