class TimePeriod < ActiveRecord::Base
  attr_accessible :day, :end_time, :start_time

  belongs_to :time_slot
  
  def startTimeString
    self.start_time.strftime("%I:%M %p")
  end
 
  
  def endTimeString
   self.end_time.strftime("%I:%M %p")
  end
end
