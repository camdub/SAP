window.App = 
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: (events) -> # called inside document.ready
  	@events = new App.Collections.Events(events) # this var can be accessed with App.events
  	@advisors = new App.Collections.Advisors() # this var can be accessed with App.events
  	@advisors.fetch({async:false})
  	@current_user = new App.Models.User(JSON.parse($("#current_user").attr("user")))
  	new App.Routers.Events
  	Backbone.history.start();
    
  # END INIT FUNC

    