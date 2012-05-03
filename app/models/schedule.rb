class Schedule < ActiveRecord::Base
 paginates_per 15
  validates_presence_of :start_time, :end_time, :phy_id

end
