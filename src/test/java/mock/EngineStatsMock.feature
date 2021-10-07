@skipme
Feature: Engine Stats mock server

  Background:
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def engineStatuses = {}
    * configure cors = true
    
  Scenario: pathMatches('/car/engine/status') && methodIs('post') && (request.carId == null || request.carId == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid car Id'}

  Scenario: pathMatches('/car/engine/status') && methodIs('post') && (request.engineFuelLevel == null || request.engineFuelLevel == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid fuel level received'}

  Scenario: pathMatches('/car/engine/status') && methodIs('post') && (request.engineHeatLevel == null || request.engineHeatLevel == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid engine heat level received'}

  Scenario: pathMatches('/car/engine/status') && methodIs('post') && (request.engineOilLevel == null || request.engineOilLevel == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid oil level received'}

  Scenario: pathMatches('/car/engine/status') && methodIs('post') && (request.engineBatteryLevel == null || request.engineBatteryLevel == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid engine battery received'}

  Scenario: pathMatches('/car/engine/status') && methodIs('post') && (request.time == null || request.time == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid time received'}

  Scenario: pathMatches('/car/engine/status') && methodIs('post') && request.carId == 'jlr0002'
    * def responseDelay = 10000
    * def engineStatus = {carId': '','engineFuelLevel': '', 'engineHeatLevel': '', 'engineOilLevel': '','engineBatteryLevel': '', 'time':''}
    * def id = uuid()
    * engineStatus.id = id
    * engineStatus.source = request.source
    * engineStatus.destination = request.destination
    * engineStatus.currentLocation = request.currentLocation
    * engineStatus.time = request.time
    * engineStatuses[id] = engineStatus
    * def responseStatus = 201
    * def response = engineStatus

  Scenario: pathMatches('/car/engine/status') && methodIs('post')
    * def engineStatus = {carId': '','engineFuelLevel': '', 'engineHeatLevel': '', 'engineOilLevel': '','engineBatteryLevel': '', 'time':''}
    * def id = uuid()
    * engineStatus.id = id
    * engineStatus.source = request.source
    * engineStatus.destination = request.destination
    * engineStatus.currentLocation = request.currentLocation
    * engineStatus.time = request.time
    * engineStatuses[id] = engineStatus
    * def responseStatus = 201
    * def response = engineStatus

  Scenario: pathMatches('/car/engine/statuses') && methodIs('get')
    * def responseStatus = 200
    * def response = $engineStatuses.*

  Scenario: pathMatches('/car/engine/status/{id}') && methodIs('get')
    * def responseStatus = 200
    * def response = engineStatuses[pathParams.id]

  Scenario:
    * def responseStatus = 404
    * def responseHeaders = { 'Content-Type': 'text/html; charset=utf-8' }
    * def response = <html><body>Not Found</body></html>