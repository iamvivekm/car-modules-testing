@skipme
Feature: Location Mock server

  Background:
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def locationInfo = {}
    * def data = {}
    * configure cors = true

  Scenario: pathMatches('/car/location') && methodIs('post') && (request.carId == null || request.carId == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid car Id'}

  Scenario: pathMatches('/car/location') && methodIs('post') && (request.source == null || request.source == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid source location received'}

  Scenario: pathMatches('/car/location') && methodIs('post') && (request.destination == null || request.destination == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid destination location received'}

  Scenario: pathMatches('/car/location') && methodIs('post') && (request.currentLocation == null || request.currentLocation == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid current location received'}

  Scenario: pathMatches('/car/location') && methodIs('post') && (request.time == null || request.time == '')
    * def responseStatus = 400
    * def responseHeaders = { 'Content-Type': 'application/json' }
    * def response = {message: 'Invalid time received'}

  Scenario: pathMatches('/car/location') && methodIs('post')
    * def location = {'carId': '', 'source': '', 'destination': '', 'currentLocation': '', 'time':''}
    * def id = uuid()
    * location.id = id
    * location.carId = request.carId
    * location.source = request.source
    * location.destination = request.destination
    * location.currentLocation = request.currentLocation
    * location.time = request.time
    * locationInfo[id] = location
    * def responseStatus = 201
    * def response = location

  Scenario: pathMatches('/car/locations') && methodIs('get')
    * def responseStatus = 200
    * def response = $locationInfo.*

  Scenario: pathMatches('/car/location/{id}') && methodIs('get')
    * def responseStatus = 200
    * def response = locationInfo[pathParams.id]

  Scenario:
    * def responseStatus = 404
    * def responseHeaders = { 'Content-Type': 'text/html; charset=utf-8' }
    * def response = <html><body>Not Found</body></html>