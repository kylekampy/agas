class Appointment < ActiveRecord::Base
  belongs_to :patient, :foreign_key => 'pat_id'
  belongs_to :physician, :foreign_key => 'phy_id'
end
