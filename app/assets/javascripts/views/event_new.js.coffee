class App.Views.NewEventView extends Backbone.View
  
  el: '#neweventdialog'
  
  template: JST['events/new']
  
  events:
    "click .cancel" : "close"
    "click .save"   : "save"
    "change #type"  : "type_list"
      
  render: =>
    el = $(@el)
    el.html(@template( 
      model: @model
      startdate: $.fullCalendar.parseDate(@model.get('start'))
      enddate: $.fullCalendar.parseDate(@model.get('end'))  
    ))
    $('body').append(@el)
    # don't know why these are not added by the modal js
    el.addClass('modal','fade')
    el.modal
      show : true
      backdrop : true
      
    $(@el).bind 'hidden', -> # this is to reset the modal for the next time its called
      $(@).remove()
      $('body').append '<div id="neweventdialog"></div>'
    @
    
  update: (event) ->
    e = $('#calendar').fullCalendar('clientEvents', event.id).shift() # first elm
    $('#calendar').fullCalendar('updateEvent', e)
          
  save: ->
    @$('.save').addClass('disabled').html 'Saving...'
    if @validate_input()
      if @options.edit == true
        @model.set(title: $('[name="apt_title"]').val()) if @model.event_type == 'Busy'
        @model.set(start: @extract_date('start'), end: @extract_date('end'))

        @model.save({}, success: (m, r) =>
          $('.modal').modal('hide')
          # the collection (event_index) handles the update
          return
        )
      else if @$('[name="type"]').val() == 'open'
        @save_open_event()
      else
        @save_busy_event()
    else
      @$('.save').removeClass('disabled').html 'Save'
    
  save_busy_event: ->
    start = @extract_date('start')
    end = @extract_date('end')
    
    new_model = new App.Models.Event({ start: start, end: end, event_type: 'Busy', title: @$('[name="apt_title"]').val(), appointments: []})
    
    new_model.save({}, 
      success: (model, response) =>
        $('.modal').modal('hide')
        return
      error: (model, response) ->
        @$('.save').removeClass('disabled').html 'Save'
        alert response.responseText
    )
    
  save_open_event: ->
    # convert into appointments
    start = @extract_date('start')
    end = @extract_date('end')
    
    duration = 30 if not @$('#apt-length').val()
    
    temp = null
    # create appointment slots
    while start.toString() != end.toString()
      if end.getHours() < start.getHours()
        alert 'break'
      temp = new Date(start)
      start.setMinutes(start.getMinutes() + duration)

      appointment_slot = new App.Models.Event( start: temp, end: start, event_type: 'Open' )
      appointment_slot.set(user_data : App.current_user.toJSON()) # add current user info to the event before saving
      
      appointment_slot.save({}, 
        success: (model, response) =>
          $('.modal').modal('hide')
          return
        error: (model, response) ->
          @$('.save').removeClass('disabled').html 'Save'
          alert response.responseText
      )
    $('#note').notify('type' : 'success', 'message' : 'Yay!')
  
  close: ->
    $(@el).modal('hide')
    
  type_list: =>
    $('#duration_section').slideToggle('fast') # duration for open
    $('#title_div').slideToggle('fast') # title for busy
  
  convert_time_to_24hr: (string)->
    timeofday = string.substring(string.length-2)
    string = string.substring(0,string.length-3)
    array = string.split(":")
    if(timeofday == "pm" && parseInt(array[0]) != 12)
      array[0] = parseInt(array[0]) + 12
    array[2] = "00"
    array.join(":")
    
  extract_date: (which) ->
    # create js date objects from our form fields using the above function
    if which == 'start'
      startdate = $('[name="startdate"]').val()
      starttime = @convert_time_to_24hr $('[name="starttime"]').val()
      date = new Date(startdate + " " + starttime)    
    else
      enddate = $('[name="enddate"]').val()
      endtime = @convert_time_to_24hr $('[name="endtime"]').val()
      return new Date(enddate + " " + endtime)
    return date 
  
  # validation is needed here in the view because the data should be 
  # validated BEFORE the open event is split into sub-events
  # otherwise, invalid data will crash before built in validation occurs
  validate_input: ->
    return true
      
    
    
    
    
    
    
    
  