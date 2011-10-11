class App.Views.NewEventView extends Backbone.View
  
  el: '#neweventdialog'
  
  events:
    "click .cancel" : "close"
    "click .save"   : "save"
  
  render: =>
    $(@el).html(JST['events/new']( model: @model ))
    console.log @model.get('start')
    $('body').append(@el)
    # don't know why these are not added by the modal js
    $(@el).addClass('modal')
    $(@el).addClass('fade')
    $(@el).modal
      show : true
      backdrop : true
      
  save: ->
    @$('.save').addClass('disabled').html 'Saving...'
    # convert into appointments
    start = $.fullCalendar.parseDate @model.get('start')
    end = $.fullCalendar.parseDate @model.get('end')
    
    #hours = (end.getHours() - start.getHours()) * 60 # in minutes
    #duration = @$('#apt_length').val()
    #num_apts = hours / duration

    #aptstart = start
    #aptend = end
    #for i in [1..num_apts] 
     # aptstart.setMinutes(start.getMinutes()*(i-1))
      #aptend.setMinutes(start.getMinutes()*i)
      #onsole.log aptstart + ' and ' + aptend
      #m = new App.Models.Event( title : 'Open', event_type : 'Open' )
    
    #console.log @model.get('end')
    #@model.save( title: 'Testing', event_type: 'Busy', color: 'red', 
     # success: (model, response) ->
      #  $('.modal').modal('hide')
       # App.events.add(model)
      #error: (model, response) ->
      #ADD ERROR HANDLING HERE
       #console.log response
    #)
      
  close: ->
    $(@el).modal('hide')