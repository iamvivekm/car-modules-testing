@skipme
Feature: Location Mock server

  Background:
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def responseMessage = ''
    * configure cors = true

  Scenario: pathMatches('/car/display/engine/{id}') && methodIs('get')
    * def id = pathParams.id
    * def responseMessage = (id == 'jlr001') ? 'Engine condition is good. Happy riding!!' : ''
    * def responseMessage = (id == 'jlr002') ? 'Warning! Engine heat is slowly building up, it is good time to take a short nap.' : responseMessage
    * def responseMessage = (id == 'jlr003') ? 'Alert! Engine is too hot, better to take a break.' : responseMessage
    * def responseMessage = (id == 'jlr004') ? 'Info! Car is running in less that 50% fuel' : responseMessage
    * def responseMessage = (id == 'jlr005') ? 'Warning! Car is running in less that 30% fuel, good to have fuel break' : responseMessage
    * def responseMessage = (id == 'jlr006') ? 'Alert! Car is running in less that 10% fuel, better to refuel now' : responseMessage
    * def responseMessage = (id == 'jlr007') ? 'Warning! Car battery level is low.' : responseMessage
    * def responseMessage = (id == 'jlr008') ? 'Alert! Car battery level is very low.' : responseMessage
    * def responseMessage = (id == 'jlr009') ? 'Warning! Engine oil level is low.' : responseMessage
    * def responseMessage = (id == 'jlr010') ? 'Alert! Engine oil level is very low. Please refill' : responseMessage
    * def responseMessage = (id == 'jlr011') ? 'Info! you have reached Leeds, traffic is normal' : responseMessage
    * def responseMessage = (id == 'jlr012') ? 'Info! you have reached Manchester, nearing your destination' : responseMessage
    * def responseMessage = (id == 'jlr013') ? 'Info! you have reached Preston, this is your destination' : responseMessage
    * def responseStatus = 200
    * def response = {message: #(responseMessage)}

  Scenario: pathMatches('/car/display/location/{id}') && methodIs('get')
    * def id = pathParams.id
    * def responseMessage = (id == 'jlr011') ? 'Info! you have reached Leeds, traffic is normal' : ''
    * def responseMessage = (id == 'jlr012') ? 'Info! you have reached Manchester, nearing your destination' : responseMessage
    * def responseMessage = (id == 'jlr013') ? 'Info! you have reached Preston, this is your destination' : responseMessage
    * def responseStatus = 200
    * def response = {message: #(responseMessage)}

  Scenario:
    * def responseStatus = 404
    * def responseHeaders = { 'Content-Type': 'text/html charset=utf-8' }
    * def response = <html><body>Car details not Found</body></html>