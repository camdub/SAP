
window.App = 
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: (events) -> # called inside document.ready
		@events = new App.Collections.Events(events) # this var can be accessed with App.events
		@current_user = eval('(' + $("#current_user").attr("user") + ')')
		new App.Routers.Events
		Backbone.history.start();
    
  # END INIT FUNC
  
    