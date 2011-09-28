class App.Routers.Events extends Backbone.Router
  
  routes:
    "" : "index"
    
  index: ->
    # create Events View and load events
    indexView = new App.Views.EventIndex(el: $('#calendar'), collection: App.events).render()
    # render that template
    
  