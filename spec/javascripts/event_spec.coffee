# loads the asset pipeline
require('/assets/application.js')
#require('/javascripts/jasmine-jquery.js')
require('/javascripts/fixtures.js')

describe 'Event model', ->
  
  beforeEach ->
    spyOn(Backbone, 'sync').andCallFake (method, model, success, error) ->
      success({"id":123,"title":"Hollywood - Part 2"})
  
  describe 'when instantiated', ->
    
    # don't want to start the router
    # FIX THIS TO JUST CALL NAVIGATE TO THE ROOT
    beforeEach ->
      App.events = new App.Collections.Events(events)
      new App.Routers.Events
      #@events = new App.Collections.Events(events)
      #indexView = new App.Views.EventIndex(el: $('#calendar'), collection: @events).render()
    
    it 'should exhibit attributes', ->
      event = new App.Models.Event
      expect(event.get('title')).toEqual 'Open'
      expect(event.urlRoot).toEqual '/events'
      
describe 'Event Creation', ->
  describe 'when a range is selected', ->
    template('new_event.html')
    
    beforeEach ->
      @startdate = new Date(2012,10,8,9,0)
      @enddate = new Date(2012,10,8,11,0)
      @view = new App.Views.NewEventView()
    
    it 'should have the correct info', ->
      # find better way to call this
      @view.model = new App.Models.Event( start: @startdate, end: @enddate )
      @view.collection = new App.Collections.Events
      @view.save()
      # should divide the event into 30 min appointment lengths
      expect(@view.collection.length).toEqual 4
      