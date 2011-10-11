namespace :app do
	desc <<-DESC
		Load Testing data into Dev database
		Run using the command 'rake app:load_demo_data'
	DESC
	task :load_demo_data do 
		
		puts "hello"
		puts User.all
		User.delete.all
		Event.delete.all
		
		dave = User.create(
			:firstname => 'Dave',
			:lastname => 'Waddell',
			:netid => 'dlw34'
		)
		paula = User.create(		
			:firstname => 'Paula',
			:lastname => 'Landon',
			:netid => 'pl',
		)
		cam = User.create(		
			:firstname => 'Cameron',
			:lastname => 'Woodmansee',
			:netid => 'wralfca',
		)
		Event.create([
		#
		#	{	
		#	  :title => , 
		#		:start => ,
		#		:end => ,
		#		:event_type => ,
		#		:participant_max => ,
		#		:user_id => 
		#	},
		#	{	
		#	  :title => , 
		#		:start => ,
		#		:end => ,
		#		:event_type => ,
		#		:user_id => 
		#	},
			{	
			  :title => 'Group',
				:start =>  Time.utc(2011,'oct',5,10,00),
				:end => Time.utc(2011,'oct',5,10,30),
				:event_type => 'Open',
				:participant_max => 5,
				:user => dave
			},
			{	
			  :title => 'Open',
				:start =>  Time.utc(2011,'oct',5,10,30),
				:end => Time.utc(2011,'oct',5,11,00),
				:event_type => 'Open',
				:user => dave
			},
			{	
			  :title => 'Open',
				:start =>  Time.utc(2011,'oct',5,11,00),
				:end => Time.utc(2011,'oct',5,11,30),
				:event_type => 'Open',
				:user => dave
			},
			{	
			  :title => 'John Smith',
				:start =>  Time.utc(2011,'oct',5,11,30),
				:end => Time.utc(2011,'oct',5,12,00),
				:event_type => 'Appointment',
				:user => dave
			},
			{	
			  :title => 'Lunch', 
				:start =>  Time.utc(2011,'oct',5,12,00),
				:end => Time.utc(2011,'oct',5,13,00),
				:event_type => 'Busy',
				:user => dave
			},
			{	
			  :title => 'Research',
				:start =>  Time.utc(2011,'oct',5,13,00),
				:end => Time.utc(2011,'oct',5,14,00),
				:event_type => 'Busy',
				:user => dave
			},
			{	
			  :title => 'Meeting', 
				:start =>  Time.utc(2011,'oct',5,14,00),
				:end => Time.utc(2011,'oct',5,16,00),
				:event_type => 'Busy',
				:user => dave
			},
      {	
			  :title => 'Jared', 
				:start =>  Time.utc(2011,'oct',5,16,00),
				:end => Time.utc(2011,'oct',5,17,00),
				:event_type => 'Appoitment',
				:user => dave
			},
			######
			{	
			  :title => 'Group',
				:start =>  Time.utc(2011,'oct',6,10,00),
				:end => Time.utc(2011,'oct',6,10,30),
				:event_type => 'Open',
				:participant_max => 5,
				:user => dave
			},
			{	
			  :title => 'Open',
				:start =>  Time.utc(2011,'oct',6,10,30),
				:end => Time.utc(2011,'oct',6,11,00),
				:event_type => 'Open',
				:user => dave
			},
			{	
			  :title => 'Open',
				:start =>  Time.utc(2011,'oct',6,11,00),
				:end => Time.utc(2011,'oct',6,11,30),
				:event_type => 'Open',
				:user => dave
			},
			{	
			  :title => 'John Smith',
				:start =>  Time.utc(2011,'oct',6,11,30),
				:end => Time.utc(2011,'oct',6,12,00),
				:event_type => 'Appointment',
				:user => dave
			},
			{	
			  :title => 'Lunch', 
				:start =>  Time.utc(2011,'oct',6,12,00),
				:end => Time.utc(2011,'oct',6,13,00),
				:event_type => 'Busy',
				:user => dave
			},
			{	
			  :title => 'Research',
				:start =>  Time.utc(2011,'oct',6,13,00),
				:end => Time.utc(2011,'oct',6,14,00),
				:event_type => 'Busy',
				:user => dave
			},
			{	
			  :title => 'Meeting', 
				:start =>  Time.utc(2011,'oct',6,14,00),
				:end => Time.utc(2011,'oct',6,16,00),
				:event_type => 'Busy',
				:user => dave
			},
      {	
			  :title => 'Jared', 
				:start =>  Time.utc(2011,'oct',6,16,00),
				:end => Time.utc(2011,'oct',6,17,00),
				:event_type => 'Appoitment',
				:user => dave
			},
			######
			{	
			  :title => 'Group',
				:start =>  Time.utc(2011,'oct',7,10,00),
				:end => Time.utc(2011,'oct',7,10,30),
				:event_type => 'Open',
				:participant_max => 5,
				:user => dave
			},
			{	
			  :title => 'Open',
				:start =>  Time.utc(2011,'oct',7,10,30),
				:end => Time.utc(2011,'oct',7,11,00),
				:event_type => 'Open',
				:user => dave
			},
			{	
			  :title => 'Open',
				:start =>  Time.utc(2011,'oct',7,11,00),
				:end => Time.utc(2011,'oct',7,11,30),
				:event_type => 'Open',
				:user => dave
			},
			{	
			  :title => 'John Smith',
				:start =>  Time.utc(2011,'oct',7,11,30),
				:end => Time.utc(2011,'oct',7,12,00),
				:event_type => 'Appointment',
				:user => dave
			},
			{	
			  :title => 'Lunch', 
				:start =>  Time.utc(2011,'oct',7,12,00),
				:end => Time.utc(2011,'oct',7,13,00),
				:event_type => 'Busy',
				:user => dave
			},
			{	
			  :title => 'Research',
				:start =>  Time.utc(2011,'oct',7,13,00),
				:end => Time.utc(2011,'oct',7,14,00),
				:event_type => 'Busy',
				:user => dave
			},
			{	
			  :title => 'Meeting', 
				:start =>  Time.utc(2011,'oct',7,14,00),
				:end => Time.utc(2011,'oct',7,16,00),
				:event_type => 'Busy',
				:user => dave
			},
      {	
			  :title => 'Jared', 
				:start =>  Time.utc(2011,'oct',7,16,00),
				:end => Time.utc(2011,'oct',7,17,00),
				:event_type => 'Appoitment',
				:user => dave
			},
			######
			{	
			  :title => 'Group',
				:start =>  Time.utc(2011,'oct',8,10,00),
				:end => Time.utc(2011,'oct',8,10,30),
				:event_type => 'Open',
				:participant_max => 5,
				:user => dave
			},
			{	
			  :title => 'Open',
				:start =>  Time.utc(2011,'oct',8,10,30),
				:end => Time.utc(2011,'oct',8,11,00),
				:event_type => 'Open',
				:user => dave
			},
			{	
			  :title => 'Open',
				:start =>  Time.utc(2011,'oct',8,11,00),
				:end => Time.utc(2011,'oct',8,11,30),
				:event_type => 'Open',
				:user => dave
			},
			{	
			  :title => 'John Smith',
				:start =>  Time.utc(2011,'oct',8,11,30),
				:end => Time.utc(2011,'oct',8,12,00),
				:event_type => 'Appointment',
				:user => dave
			},
			{	
			  :title => 'Lunch', 
				:start =>  Time.utc(2011,'oct',8,12,00),
				:end => Time.utc(2011,'oct',8,13,00),
				:event_type => 'Busy',
				:user => dave
			},
			{	
			  :title => 'Research',
				:start =>  Time.utc(2011,'oct',8,13,00),
				:end => Time.utc(2011,'oct',8,14,00),
				:event_type => 'Busy',
				:user => dave
			},
			{	
			  :title => 'Meeting', 
				:start =>  Time.utc(2011,'oct',8,14,00),
				:end => Time.utc(2011,'oct',8,16,00),
				:event_type => 'Busy',
				:user => dave
			},
      {	
			  :title => 'Jared', 
				:start =>  Time.utc(2011,'oct',8,16,00),
				:end => Time.utc(2011,'oct',8,17,00),
				:event_type => 'Appoitment',
				:user => dave
			},
		])
  end
end