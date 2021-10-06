@parallel=false
@cardisplay
Feature: Validate the Car display features

  Background:
    * def port = karate.start('classpath:mock/DisplayMock.feature').port
    * url url + port + '/car'

  Scenario Outline: Validate engine status for display
    Given path 'display/engine', '<carId>'
    And method get
    Then status 200
    And match response.message == <message>
    Examples:
      | carId  | message                                                                            |
      | jlr001 | 'Engine condition is good. Happy riding!!'                                         |
      | jlr002 | 'Warning! Engine heat is slowly building up, it is good time to take a short nap.' |
      | jlr003 | 'Alert! Engine is too hot, better to take a break.'                                |
      | jlr004 | 'Info! Car is running in less that 50% fuel'                                       |
      | jlr005 | 'Warning! Car is running in less that 30% fuel, good to have fuel break'           |
      | jlr006 | 'Alert! Car is running in less that 10% fuel, better to refuel now'                |
      | jlr007 | 'Warning! Car battery level is low.'                                               |
      | jlr008 | 'Alert! Car battery level is very low.'                                            |
      | jlr009 | 'Warning! Engine oil level is low.'                                                |
      | jlr010 | 'Alert! Engine oil level is very low. Please refill'                               |
      | jlr011 | 'Info! you have reached Leeds, traffic is normal'                                  |
      | jlr012 | 'Info! you have reached Manchester, nearing your destination'                      |
      | jlr013 | 'Info! you have reached Preston, this is your destination'                         |