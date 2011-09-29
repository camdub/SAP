window.App = 
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: (events) -> # called inside document.ready
    @events = new App.Collections.Events(events); # this var can be accessed with App.events
    new App.Routers.Events
    Backbone.history.start();
    
  # END INIT FUNC
  
    