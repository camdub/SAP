require('/assets/application.js')

describe 'Event model', ->

  it 'passes', ->
    new App.Models.Event()
    expect('love').toEqual('love')