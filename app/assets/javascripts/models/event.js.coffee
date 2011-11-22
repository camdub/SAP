class App.Models.Event extends Backbone.Model
  
  urlRoot: '/events'
  
  defaults:
    'title' : 'Open'
    #'appointments' : []
    
  initialize: -> # set a collection of appointments
    appointments = new App.Collections.Appointments
    appointments.reset(@get('appointments')) if @get('appointments') != undefined
    @appointments = appointments
 
  validate: ->
    errors = []
    if @get 'start' > @get 'end'
      errors.push('Start cannot be less than end date')
      errors
    else
      return