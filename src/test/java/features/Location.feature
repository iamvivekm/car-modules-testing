@parallel=false
@car-side
Feature: Validate the Location api

  Background:
    * def port = karate.start('classpath:mock/LocationMock.feature').port
    * url url + port + '/car'
    * def locationPayload = {'carId': 'jlr0001', 'source': 'Bradford', 'destination': 'Leeds', 'currentLocation': 'Shipley', 'time':'12.30'}
    * def locationInfo = {}

  Scenario: Add a valid car location
    Given path 'location'
    When request locationPayload
    And method post
    Then status 201
#    Sample for chaining to validate whether the created request is saved
    And json initialResponse = response
    Given path 'location/' + initialResponse.id
    When method get
    Then status 200
    And match response == initialResponse
#    Preserve the response for further validation
    * locationInfo[initialResponse.id] = initialResponse
    Given path 'location'
    When request locationPayload
    And method post
    Then status 201
    * locationInfo[response.id] = response
    Given path 'locations'
    And method get
    Then match response == $locationInfo.*

  Scenario Outline: Add an Invalid car <fieldName> with null value
    Given path 'location'
    When set locationPayload.<fieldName> = null
    And request locationPayload
    And method post
    Then status 400
    And match response == {'message': <errorMessage>}
    Examples:
      | fieldName       | errorMessage                            |
      | carId           | "Invalid car Id"                        |
      | source          | "Invalid source location received"      |
      | destination     | "Invalid destination location received" |
      | currentLocation | "Invalid current location received"     |
      | time            | "Invalid time received"                 |


  Scenario Outline: Add an Invalid car <fieldName> with empty value
    Given path 'location'
    When set locationPayload.<fieldName> = ''
    And request locationPayload
    And method post
    Then status 400
    And match response == {'message': <errorMessage>}
    Examples:
      | fieldName       | errorMessage                            |
      | carId           | "Invalid car Id"                        |
      | source          | "Invalid source location received"      |
      | destination     | "Invalid destination location received" |
      | currentLocation | "Invalid current location received"     |
      | time            | "Invalid time received"                 |

  Scenario: Get all the car locations
    Given path 'locations'
    When method get
    Then status 200
    * print response