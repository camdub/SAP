class App.Views.EventIndex extends Backbone.View
  events: 
   "change #calendar_selection" : "change_active_calendar"
   
  initialize: ->
    
    faye.subscribe("/events/new", (data) =>
      #alert("came back from server")
      @collection.add(new App.Models.Event(data))
      #alert("after add")
    )
    
    faye.subscribe("/events/delete", (id) =>
      @collection.remove(@collection.get(id))
    )
    
    faye.subscribe("/events/update", (data) =>
      console.log('updated')
      @collection.remove(data.id)
      @collection.add(new App.Models.Event(data))
    )
    
    @collection.bind('reset', @addAll)
    @collection.bind('add', @add)
    @collection.bind('remove', @remove)
    @collection.bind('change', @update)
    #@view = new App.Views.NewEventView(collection: @collection)
    
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
      eventAfterRender: @after_render
      selectable: true
      selectHelper: true
      eventColor: '#000000'
      eventClick: @event_click
    @collection.trigger('reset', App.current_user) # trigger addAll method
    @el.prepend(JST['events/calendar_select']())
    
  # Triggered after fullCalendar loads
  # Loads all events in the collection into the calendar (creates event obj)
  # based on the current user and which user's calendar is currently selected  
  addAll: (user) =>
    # add colors for events
    @collection.each((event) ->
      event.color = 'red' if event.get('event_type') == 'Busy'
      event.color = 'green' if event.get('event_type') == 'Open'
    )
    
    this_users_events = @collection.filter( (event)->
      return event.get("user").netid == user.get("netid")
    )    
    this_users_events = _.map(this_users_events, (event)-> 
      event.color = 'red' if event.get('event_type') == 'Busy'
      event.color = 'green' if event.get('event_type') == 'Open'
      return event.toJSON()
    )
    
    @el.fullCalendar('addEventSource', this_users_events)
    $('.fc-event').fadeIn(1000);
    
  # Triggered after a new event is added to the collection
  # Renders a single event to the calendar
  add: (event) =>
    @el.fullCalendar('renderEvent', event.toJSON())
    
  remove: (event) =>
    $('.popover').css('display','none')
    @el.fullCalendar('removeEvents', event.id)
    $('.fc-event').css('display','block')
    
  update: (event) =>
    @remove(event)
    @add(event)
    #@el.fullCalendar('renderEvent', event.toJSON())
    
  # Called by eventRender callback of fullCalendar  
  # Loads the detail view into the popover and initializes the popover  
  event_detail: (event, element) =>
    # TODO - SET COLORS FOR EVENTS
    color = 'blue'
    if event.event_type == 'Open'
      color = 'green'
    else if event.event_type == 'Busy'
      color = 'red'

    $(element).css('background-color',color)
    $(element).css('border-color',color)
    
    $(element).find('div').css('background-color',color)
    $(element).find('div').css('border-color',color)

    return
    
  # Called after the user makes a selection on the calendar
  # Creates a new event and asks the user for more input via a model windoow
  select: (startdate, enddate) =>
    # check to see if this user can edit current calendar
    if App.current_user.get('netid') == App.advisors.getByCid($("#calendar_selection").val()).get('netid')
      view = new App.Views.NewEventView(collection: @collection)
      view.model = new App.Models.Event( start: startdate.toString(), end: enddate.toString() )
      view.render()
    else
      @el.fullCalendar('unselect')
      $('#note').notify('type' : 'error', 'message' : 'Cannot edit another user\'s calendar.')
    
  change_active_calendar: ->
    selected_user =  App.advisors.getByCid($("#calendar_selection").val())
    $('.fc-event').fadeOut('fast', =>
      @el.fullCalendar('removeEvents')
      @collection.trigger('reset', selected_user) # trigger addAll method
    );
      
  after_render: (event, element)=>
    if event.event_type == 'Open'
      if event.title == 'Open'
        link_name = 'book'
      else
        link_name = 'remove'
     
      console.log link_name
      # set up to add book link to opend events
      element.find('.fc-event-time').append("<span id='book-#{event.id}' class='book' style='float:right'><a href='#'>" + link_name + "</a></span>")

    element.popover # set popover options
      placement: 'left'
      fallback: 'Testing'
      offset: 3
      trigger: 'manual'
      html: true # allows template to be rendered for content
      
    # the following must be called here.  All events in the Detail view are bound to the popover
    # any popover related events needing to be bound to the event happens here
    element.attr('title', event.title) # popover takes title from title attr
    element.attr('data-content', JST['events/detail']( model: event ))
    element.attr('cal_event',"#{event.id}")
    
    #event.click ->
    new App.Views.EventDetailView(model : @collection.get(event.id), el: $(element), collection: @collection)
    ###      
      $('#new_apt').keypress((e)=>
        console.log $(e.target).attr('event')
        console.log event.id
        text = $('input[name="student_name"]').val()
        if (!text || e.keyCode != 13) 
          return
        else if parseInt($(e.target).attr('event')) != event.id
          return
        # CREATE APPOINTMENT HERE
        #console.log $(e.target).attr('event')
        #console.log event.id
        element.popover('hide')
        event.color = 'blue'
        event.title = text
        @el.fullCalendar('updateEvent', event)
        $("#book-#{event.id}").toggleClass('inactive')
      )
      $('.close').click(->
        element.popover('hide')
      )###
    return # the popover doesn't work if it is returned
    
      
      
    
    
    