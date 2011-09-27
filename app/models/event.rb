class Event < ActiveRecord::Base
  
  belongs_to :user
  has_many :appointments # to allow for group advisement?
  
  #name could be blank = Open slots have no name??
  validates :participant_max, :format => { :with => /[0-9]/ } #must be number
  validates :event_type, :format => { :with => /(Appointment|Busy|Open)/i }
  
  # TODO - put custom validations in their own file
  
  #validates :end_datetime, :chronological => true
  validates_each :end_datetime, do |model, attr, value|
    model.errors.add(attr, 'cannot be before start time.') if 
      (model.end_datetime - model.start_datetime) <= 0
  end
  
end
