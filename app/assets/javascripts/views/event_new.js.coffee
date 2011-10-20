class App.Views.NewEventView extends Backbone.View
  
  el: '#neweventdialog'
  
  events:
    "click .cancel" : "close"
    "click .save"   : "save"
    "change #type"  : "type_list"
  
  render: =>
    console.log(@model)
    $(@el).html(JST['events/new']( 
      model: @model
      startdate: $.fullCalendar.parseDate(@model.get('start'))
      enddate: $.fullCalendar.parseDate(@model.get('end'))  
    ))
    $('body').append(@el)
    # don't know why these are not added by the modal js
    $(@el).addClass('modal')
    $(@el).addClass('fade')
    $(@el).modal
      show : true
      backdrop : true
      
  save: ->
    @$('.save').addClass('disabled').html 'Saving...'
    console.log('enter save' + typeof(@model.get('start')))
    # convert into appointments
    start = $.fullCalendar.parseDate @model.get('start')
    end = $.fullCalendar.parseDate @model.get('end')
    duration = 30 if not @$('#apt-length').val()
      
    temp = null
    # create appointment slots
    while start.toString() != end.toString()
      temp = new Date(start)
      start.setMinutes(start.getMinutes() + duration)

      appointment_slot = new App.Models.Event( start: temp, end: start, event_type: 'Open' )
      appointment_slot.set(user_data : App.current_user.toJSON()) # add current user info to the event before saving
      console.log appointment_slot
      
      @collection.create(appointment_slot, 
        success: (model, response) =>
          $('.modal').modal('hide')
          return
        error: (model, response) ->
          #TODO
          alert response.responseText
      )
    
  close: ->
    $(@el).modal('hide')
    
  type_list: =>
    $('#duration_section').slideToggle('fast')