@api
Feature: Events JSON Service
	As an API user
	MyGuide should
	Provide a resource for interacting with calendar events
	
	Background:
		Given the following event records:
			| name  | event_type |
			| Test1 | Open 			 |
			| Test2 | Open			 |
		And I send and accept JSON
	
	# INDEX
	Scenario: GET to the events resource should return an array of events
		Given I send a GET request for "/events"
		Then the response status should be "200"
		And the JSON response should have "$.[0].name" with the text "Test1"
		And the JSON response should have "$.[1].name" with the text "Test2"
		
	# CREATE
	Scenario: POST to events should create a new event
		Given I send a valid POST request to "/events" with the default event data
		Then the response status should be "200"
		And the JSON response should have "$.id" with the text "3"
		
	Scenario: POST to events with invalid data should return an error
		Given I send an invalid POST request to "/events" with the following event data:
			|event_type|
			| fun time |
		And the response status should be "422"
		And the JSON response should have "$.[0]" with the text "Event type is invalid"
		
	# SHOW
	Scenario: GET to events/1 should return a valid event object
		Given I send a GET request for "events/1"
		Then the response status should be "200"
		And the JSON response should have "$.name" with the text "Test1"
		
	Scenario: GET to events/some_id that doesn't exist should return an error and 404
		Given I send a GET request for "events/20"
		Then the response status should be "404"
		And the JSON response should have "$.message" with the text "Couldn't find Event with id=20"
	
	# UPDATE	
	Scenario: PUT to events/1 with valid data should update the event
		Given I send a valid PUT request to "/events/1" with the following event data:
			| 		 name 		|
			| Test1_updated |
		Then the response status should be "200"
		And the JSON response should have "$.name" with the text "Test1_updated"
		
	Scenario: PUT to events/1 with invalid data should error
		Given I send an invalid PUT request to "/events/1" with the following event data:
			|		event_type	|
			|		  no_type		|
		Then the response status should be "422"
		And the JSON response should have "$.[0]" with the text "Event type is invalid"
		
	# DELETE
	Scenario: DELETE to events/1 should delete the event
		Given I send a DELETE request to "/events/1"
		And the response status should be "200"
		