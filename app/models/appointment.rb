class Appointment < ActiveRecord::Base
  belongs_to :patient, :foreign_key => 'pat_id'
  belongs_to :physician, :foreign_key => 'phy_id'

  validate :is_valid_apt_time

  def is_valid_apt_time
    if(!is_available?(self.start_time, self.end_time))
      self.errors[:base] << "This physician does not have that time available for an appointment."
    end
  end

#-- What follows is everything for determining time coordination --#
  def self.available_times(phy_id)
    avail_times = []
    unavail_times = []
    schedules = Schedule.where(:phy_id => phy_id)
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
    unavail_times.each do |cur_unavail_time|
      remove_time_block(avail_times, cur_unavail_time)
    end

    return avail_times
  end

  def self.available_future_times(phy_id)
    times = available_times(phy_id)
    times.each do |time|
      if(time.start_time < Time.now)
        times.delete(time)
      end
    end
  end

  def is_available?(start_time, end_time)
    return Appointment.is_available?(self.phy_id, start_time, end_time)
  end

  def self.is_available?(phy_id, start_time, end_time)
    avail_times = available_times(phy_id)
    puts "avail_times = #{avail_times}"
    block = TimeBlock.new(start_time, end_time)
    if(block_within_times?(avail_times, block))
      true
    else
      false
    end
  end

  def self.remove_time_block(time_blocks, block_to_remove)
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

  def self.block_within_times?(time_blocks, block_to_check)
    containing_block = get_containing_block(time_blocks, block_to_check)
    if(containing_block)
      true
    else
      false
    end
  end

  def self.get_containing_block(time_blocks, block_to_get)
    time_blocks.each do |cur_block|
      puts "cur_block.start_time = #{cur_block.start_time}"
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
      @start_time = start_t
      @end_time = end_t
    end
    
    #Method to check if our time block contains block_of_time
    def contains_block?(block_of_time)
      if(self.start_time <= block_of_time.start_time &&
         self.end_time >= block_of_time.end_time)
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
