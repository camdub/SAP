class App.Models.Event extends Backbone.Model
  
  urlRoot: '/events'
  
  defaults:
    'title' : 'Open'
    
  validate: ->
    errors = []
    if @get 'start' > @get 'end'
      errors.push('Start cannot be less than end date')
      errors
    else
      return