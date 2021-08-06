# Created by BenT at 06/08/2021
Feature: Functional test - check http connection
  Scenario: check http connection to web server
    Given i want to send http get request to "http://app-server/" and check that the response is "200"

  Scenario: Functional test - /greet endpoint
    Given i want to send http get request to "http://app-server/greet" and check that the response content equals "greetings"
