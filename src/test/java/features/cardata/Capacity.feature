Feature: Validate the Engine Stats api

  Background:
    * url url
    * def engineStatusPayload = {'carId': 'jlr0001','engineFuelLevel': '65.4', 'engineHeatLevel': '73.2', 'engineOilLevel': '82.5','engineBatteryLevel': '75.7', 'time':'13.45'}

  @engineperf
  Scenario: Valid a delayed engine status response
    Given path 'engine/status'
    * header karate-name = 'Engine Stats'
    When request engineStatusPayload
    And method post
    Then status 201