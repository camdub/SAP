Factory.define :user do |f|
  f.firstname "Cameron"
  f.lastname "Woodmansee"
  f.netid "wralphca"
end

Factory.define :event do |f|
  f.name "Event Name"
  f.event_type "Open"
  f.start_datetime Time.now
  f.end_datetime (Time.now + (30*60)) # 30 minutes, default
  f.association :user
end

Factory.define :appointment do |f|
  f.association :user
  f.notes ""
  f.status "Scheduled"
  f.event_id nil # should be overwritten on creation
end