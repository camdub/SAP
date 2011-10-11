class App.Views.EventDetailView extends Backbone.View
  
  render: ->
    @el.attr('title', @model.title) # popover takes title from title attr
    @el.attr('data-content', JST['events/detail']( model: @model ))