class Schedule < ActiveRecord::Base

  validates_presence_of :start_time, :end_time, :phy_id

end
