class App.Views.EventDetailView extends Backbone.View
  
  events:
    "click .book" : 'focus_name_field'
    "keypress #new_apt" : 'enterhit'
  
  render: ->
    @el.attr('title', @model.title) # popover takes title from title attr
    @el.attr('data-content', JST['events/detail']( model: @model ))
    @delegateEvents()

  focus_name_field: ->
    alert 'here'
    $('input[name="student_name"]').focus()
    
  enterhit:(e) ->
    alert 'enter'