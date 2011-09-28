class App.Views.EventIndex extends Backbone.View
  
  initialize: ->
    @collection.bind('reset', @addAll)
    
  render: =>
    @el.fullCalendar
      header:
        left: 'prev,next today'
        center: 'title'
        right: 'month,agendaWeek,agendaDay'
        ignoreTimezone: false
      weekends: false
      defaultView: 'agendaWeek'
      minTime: 7
      maxTime: 20
    @collection.trigger('reset') # trigger addAll method
    
  addAll: =>
    console.log @collection.toJSON()
    @el.fullCalendar('addEventSource', @collection.toJSON())