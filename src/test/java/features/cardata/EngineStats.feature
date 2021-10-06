@parallel=false
@cardata
@regression
Feature: Validate the Engine Stats api

  Background:
    * def port = karate.start('classpath:mock/EngineStatsMock.feature').port
    * url url + port + '/car'
    * def engineStatusPayload = {'carId': 'jlr0001','engineFuelLevel': '65.4', 'engineHeatLevel': '73.2', 'engineOilLevel': '82.5','engineBatteryLevel': '75.7', 'time':'13.45'}
    * def engineStatusInfo = {}

  @smoke
  Scenario: Add a valid engine status
    Given path 'engine/status'
    When request engineStatusPayload
    And method post
    Then status 201
#    Sample for chaining to validate whether the created request is saved
    And json initialResponse = response
    Given path 'engine/status/' + initialResponse.id
    When method get
    Then status 200
    And match response == initialResponse
#    Preserve the response for further validation
    * engineStatusInfo[initialResponse.id] = initialResponse
    Given path 'engine/status'
    When request engineStatusPayload
    And method post
    Then status 201
    * engineStatusInfo[response.id] = response
    Given path 'engine/statuses'
    And method get
    Then match response == $engineStatusInfo.*

  Scenario Outline: Add an Invalid car <fieldName> with null value
    Given path 'engine/status'
    When set engineStatusPayload.<fieldName> = null
    And request engineStatusPayload
    And method post
    Then status 400
    And match response == {'message': <errorMessage>}
    Examples:
      | fieldName          | errorMessage                         |
      | carId              | "Invalid car Id"                     |
      | engineFuelLevel    | "Invalid fuel level received"        |
      | engineHeatLevel    | "Invalid engine heat level received" |
      | engineOilLevel     | "Invalid oil level received"         |
      | engineBatteryLevel | "Invalid engine battery received"    |
      | time               | "Invalid time received"              |


  Scenario Outline: Add an Invalid car <fieldName> with empty value
    Given path 'engine/status'
    When set engineStatusPayload.<fieldName> = ''
    And request engineStatusPayload
    And method post
    Then status 400
    And match response == {'message': <errorMessage>}
    Examples:
      | fieldName          | errorMessage                         |
      | carId              | "Invalid car Id"                     |
      | engineFuelLevel    | "Invalid fuel level received"        |
      | engineHeatLevel    | "Invalid engine heat level received" |
      | engineOilLevel     | "Invalid oil level received"         |
      | engineBatteryLevel | "Invalid engine battery received"    |
      | time               | "Invalid time received"              |

  Scenario: Get all engine statuses
    Given path 'engine/statuses'
    When method get
    Then status 200
    * print response