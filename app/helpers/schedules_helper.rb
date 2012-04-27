module SchedulesHelper

  def available_times(phy_id)
    avail_times, unavail_times = []
    schedules = Schedule.find(phy_id)
    appts = Appointment.where(:phy_id => phy_id)
    #First, populate available times
    schedules.each do |cur_sch|
      avail_times << TimeBlock.new(cur_sch.start_time, cur_sch.end_time)
    end
    #Now, populate unavailable times
    appts.each do |cur_apt|
      unavail_times << TimeBlock.new(cur_apt.start_time, cur_apt.end_time)
    end
    #Now, cycle through unavil_times, and take each out of avail_times
    unavil_times.each do |cur_unavail_time|
      remove_time_block(avail_times, cur_unavail_time)
    end

    return avail_times
  end

  def is_available?(phy_id, start_time, end_time)
    avail_times = available_times(phy_id)
    block = TimeBlock.new(start_time, end_time)
    if(block_within_times?(avail_times, block))
      true
    else
      false
    end
  end

private

  def remove_time_block(time_blocks, block_to_remove)
    if(block_within_times?(time_blocks, block_to_remove))
      #Go ahead and remove it
      block_to_break = get_containing_block(time_blocks, block_to_remove)
      if(block_to_break.start_time == block_to_remove.start_time)
        #Can just modifiy our block_to_break and shift it
        block_to_break.start_time = block_to_remove.end_time
      elsif(block_to_break.end_time == block_to_remove.end_time)
        #Again, just shift the end time in block_to_break
        block_to_break.end_time = block_to_remove.start_time
      else
        #Well, now we need 2 blocks since we've really been split
        newBlock1 = nil
        newBlock2 = nil
        #newBlock1 will be the earlier block
        newBlock1 = TimeBlock.new(block_to_break.start_time, block_to_remove.start_time)
        #newBlock2 will be the later block
        newBlock2 = TimeBlock.new(block_to_remove.end_time, block_to_break.end_time)
        #Remove the old block from time blocks
        time_blocks.delete(block_to_break)
        #Add the 2 new ones
        time_blocks << newBlock1
        time_blocks << newBlock2
      end
    end
    time_blocks.sort
  end

  def block_within_times?(time_blocks, block_to_check)
    containing_block = get_containing_block(block_times, block_to_check)
    if(containing_block)
      true
    else
      false
    end
  end

  def get_containing_block(block_times, block_to_get)
    time_blocks.each do |cur_block|
      if(cur_block.contains_block?(block_to_get))
        return cur_block
      end
    end
    nil
  end

  class TimeBlock
    attr_accessor :start_time, :end_time
    
    def initialize(start_t, end_t)
      if(start_t >= end_t)
        throw Exception.new("End time must be after start time")
      end
      start_time = start_t
      end_time = ent_t
    end
    
    #Method to check if our time block contains block_of_time
    def contains_block?(block_of_time)
      if(start_time <= block_of_time.start_time &&
         end_time >= block_of_time.end_time)
        true
      else
        false
      end
    end
    
    def <=>(block)
      self.start_time <=> block.start_time
    end
  end
end
