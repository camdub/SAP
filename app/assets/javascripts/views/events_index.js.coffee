class App.Views.EventIndex extends Backbone.View
  events: 
   "change #calendar_selection" : "change_active_calendar"
   
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
      eventAfterRender: @after_render
      selectable: true
      selectHelper: true
      eventColor: 'green'
    @collection.trigger('reset', App.current_user) # trigger addAll method
    @el.prepend(JST['events/calendar_select']())
    
  # Triggered after fullCalendar loads
  # Loads all events in the collection into the calendar (creates event obj)
  # based on the current user and which user's calendar is currently selected  
  addAll: (user) =>
    this_users_events = @collection.filter( (event)->
      return event.get("user_data").netid == user.get("netid")
    )    
    this_users_events = _.map(this_users_events, (event)-> 
      return event.toJSON()
    )  
    @el.fullCalendar('addEventSource', this_users_events)
    $('.fc-event').fadeIn(1000);
    
  # Triggered after a new event is added to the collection
  # Renders a single event to the calendar
  add: (event) =>
    @el.fullCalendar('renderEvent', event.toJSON())
    
  remove: (event) =>
    console.log event.id
    $('.popover').css('display','none')
    @el.fullCalendar('removeEvents', event.id)
    $('.fc-event').css('display','block')
    
  # Called by eventRender callback of fullCalendar  
  # Loads the detail view into the popover and initializes the popover  
  event_detail: (event, element) =>
    return
    
  # Called after the user makes a selection on the calendar
  # Creates a new event and asks the user for more input via a model windoow
  select: (startdate, enddate) =>
    # check to see if this user can edit current calendar
    if App.current_user.get('netid') == App.advisors.getByCid($("#calendar_selection").val()).get('netid')
      @view.model = new App.Models.Event( start: startdate.toString(), end: enddate.toString() )
      @view.collection = @collection
      @view.render()
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
      element.find('.fc-event-time').append("<span id='book-#{event.id}' class='book' style='float:right'><a href='#'>book</a></span>")
    #new App.Views.EventDetailView(model : event, el : element).render()
    element.popover
      placement: 'left'
      fallback: 'Testing'
      offset: 3
      trigger: 'manual'
      html: true # allows template to be rendered for content
    console.log event
    element.attr('title', event.title) # popover takes title from title attr
    element.attr('data-content', JST['events/detail']( model: event ))
    #new App.Views.EventDetailView(model : event, el : element).render()
    element.click => 
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
      )###
      $('.close').click(->
        element.popover('hide')
      )
      return # the popover doesn't work if it is returned
    
      
      
    
    
    