class App.Views.EventDetailView extends Backbone.View
  
  events:
    "click"             : "popover"
  
  render: ->
    @el.popover('show')
    @
    
  popover: ->
    $('.popover').remove()
    @render()
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