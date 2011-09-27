@app
Feature: Appointment JSON Service
	As an API user
	MyGuide should
	Provide a method to add appointments to events
	
	Background:
		Given the following event records:
			| name  | event_type |
			| Test1 | Open 			 |
			| Test2 | Open			 |
		And I send and accept JSON
		
	Scenario: POST to appointments should create a valid appointment linked to an event
		Given I send a valid POST request to "/appointments" with the following appointment data:
		|  event_id  |
		| 		1			 |
		Then the response status should be "200"
		And the JSON response should have "$.id" with the text "1"
		And the JSON response should have "$.event_id" with the text "1"
		
	Scenario: POST to events with invalid data should return an error
		Given I send an invalid POST request to "/appointments" with the following event data:
			|status|
			| giberish |
		And the response status should be "422"
		And the JSON response should have "$.[0]" with the text "Status is invalid"