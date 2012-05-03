module SchedulesHelper

  def future_schedules(schedules, months=-1)
    time_in_a_month = 2592000
    time_dilation = time_in_a_month * 12 #Default to a year
    if(months > 0)
      time_dilation = time_in_a_month * months
    end
    ret_schedules = []
    schedules.each do |schedule|
      if(schedule.start_time > (Time.now-86400) && schedule.start_time < (Time.now + time_dilation))
        ret_schedules << schedule
      end
    end
    ret_schedules
  end
  
end
