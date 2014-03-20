Feature:  
  In order to get basic values out of the data API
  As an API client
  I want to be able to fetch observations

  Background:
    Given I send and accept JSON
  
  Scenario: fetch a single observation
    Given an observation exists in the database
    When I visit the URL for that observation
    Then the response status should be "200"
    And the response content type should be JSON
    And the JSON response should have "$.measure" with the text "111.5"
    And the JSON response should have "$.date" with the text "December 2013"
    And the JSON response should have "$.cdid" with the text "Alcoholic Beverages - SPECIAL INDEX FOR USE IN NSO - Manu incl duty"
