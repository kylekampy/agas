class MedicalStaff < ActiveRecord::Base
  has_one :login, :as => :owner
  has_one :physician
end
