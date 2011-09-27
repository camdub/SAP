class Appointment < ActiveRecord::Base
  
  belongs_to :event
  
  validates :status, :format => { :with => /(Scheduled|In Progress|Completed|No Show)/i }
  
end
