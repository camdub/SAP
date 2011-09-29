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
      eventRender: @event_detail
    @collection.trigger('reset') # trigger addAll method
   
  # Triggered after fullCalendar loads
  # Loads all events in the collection into the calendar (creates event obj)  
  addAll: =>
    @el.fullCalendar('addEventSource', @collection.toJSON())
    
  # Called by eventRender callback of fullCalendar  
  # Loads the detail view into the popover and initializes the popover  
  event_detail: (event, element) =>
    console.log element
    element.popover
      placement: 'left'
      fallback: 'Testing'
      offset: 3
      trigger: 'manual'
      html: true # allows template to be rendered for content
    element.click ->
      new App.Views.EventDetailView(model : event, el : element).render()
      element.popover('show')
      
    # if the user clicks outside of the event or popover, hide it
    $(document).click (event) ->
      if $(event.target).parents('.popover').length == 0 && $(event.target).parents('.fc-event').length == 0
        element.popover('hide')
    return # the popover doesn't work if it is returned