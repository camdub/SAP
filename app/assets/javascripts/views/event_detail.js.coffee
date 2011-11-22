class App.Views.EventDetailView extends Backbone.View
  
  events:
    "click"             : "popover"
    "click .book"                 : "edit_appointment"
  
  initialize: ->
    # bind events from this model's appointment collection
    @model.appointments.bind('add', @render_appointment)
  
  render: ->
    @el.popover('show')
    @
    
  popover: (e) ->
    $('.popover').remove()
    @render()
    $('input[name="student_name"]').focus() 

    $('.close').click =>
      @el.popover('hide')

    $('.edit').click =>
      if $('.edit').html() == 'edit'
        view = new App.Views.NewEventView(model: @model, collection: @collection, edit: true)
        view.render()
        @el.popover('hide')
    
    $('.delete').live 'click', =>
        c = confirm('Are you Sure?')
        if c
          @model.destroy()
          @collection.remove(@model)
    
    text = $('#new_apt')    
    text.keypress (e) =>
      if(!text || e.keyCode != 13)
        return
      else
        model = new App.Models.Appointment(title: text.val(), status: 'Scheduled', user_id: App.current_user.get('id'), event_id: @model.id)
        model.save({},
          success: (m, r) =>
            @el.popover('hide')
        )
        @model.appointments.add(model)
        @model.save(title: text.val())
    
  render_appointment: (apt) =>
    @collection.trigger('change', @collection.get(@model.id))
    
  edit_appointment: =>
    value = @$("#book-#{@model.id} a")
    console.log value
    if value.html() == 'remove'
      @el.popover('hide')
      c = confirm("Are you sure you want to remove #{@model.get('title')} from this appointment?")
      if c
        @model.save(title: 'Open', color: 'green')
        @model.appointments.remove(@model.appointments.at(0))
        @collection.trigger('change', @collection.get(@model.id))
    
    ###

  

  focus_name_field: ->
    $('input[name="student_name"]').focus()
    
  enterhit:(e) ->
    alert 'ente'
    text = $('input[name="student_name"]').val()
    if (!text || e.keyCode != 13) 
      return
    else if parseInt($(e.target).attr('event')) != @model.get('id')
      return
    # CREATE APPOINTMENT HERE
    #console.log $(e.target).attr('event')
    #console.log event.id
    $(@).popover('hide')
    event.color = 'blue'
    event.title = text
    $('#calendar').fullCalendar('updateEvent', event)
    $("#book-#{event.id}").toggleClass('inactive')