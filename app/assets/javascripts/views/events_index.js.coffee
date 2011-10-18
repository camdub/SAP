class App.Views.EventIndex extends Backbone.View
     
  initialize: ->
    @collection.bind('reset', @addAll)
    @collection.bind('add', @add)
    @collection.bind('remove', @remove)
    @view = new App.Views.NewEventView()
    
  render: =>
    @el.fullCalendar
      header:
        left: 'prev,next today'
        center: 'title'
        right: 'month,agendaWeek,agendaDay'
        ignoreTimezone: false
      weekends: false
      defaultView: 'agendaWeek'
      minTime: 8
      maxTime: 18
      select: @select
      eventRender: @event_detail
      selectable: true
      selectHelper: true
    @collection.trigger('reset') # trigger addAll method
   
  # Triggered after fullCalendar loads
  # Loads all events in the collection into the calendar (creates event obj)  
  addAll: =>
    @el.fullCalendar('addEventSource', @collection.toJSON())
    
  # Triggered after a new event is added to the collection
  # Renders a single event to the calendar
  add: (event) =>
    @el.fullCalendar('renderEvent', event.toJSON())
    
  remove: (event) =>
    $('.popover').css('display','none')
    @el.fullCalendar('removeEvents', event.id)
    
  # Called by eventRender callback of fullCalendar  
  # Loads the detail view into the popover and initializes the popover  
  event_detail: (event, element) =>
    element.popover
      placement: 'left'
      fallback: 'Testing'
      offset: 3
      trigger: 'manual'
      html: true # allows template to be rendered for content
    element.click =>
      new App.Views.EventDetailView(model : event, el : element).render()
      currModel = @collection.get(event.id)
      $('.popover').css('display','none')
      element.popover('show')
      edit = $('.edit')
      edit.attr('event',"#{event.id}")
      edit.click(=>
        if edit.html() == 'edit'
          @view.model = currModel
          @view.render()
      )
      $('.delete').click(=>
          c = confirm('Are you Sure?')
          if c
            model = currModel
            model.destroy()
            @collection.remove(model)
      )
      $('.close').click(->
        element.popover('hide')
      )
    return # the popover doesn't work if it is returned
    
  # Called after the user makes a selection on the calendar
  # Creates a new event and asks the user for more input via a model windoow
  select: (startdate, enddate) =>
    @view.model = new App.Models.Event( start: startdate.toString(), end: enddate.toString() )
    @view.collection = @collection
    @view.render()
    
  
  
  
  
  
  