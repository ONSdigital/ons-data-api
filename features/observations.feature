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
    And the JSON response should have "$.price_index" with the text "111.5"
    And the JSON response should have "$.date" with the text "2013DEC"
    And the JSON response should have "$.product" with the text "MC6A"
    And the JSON response should have "$.price_index" with the text "111.5"
    And the JSON response should have "$.dimensions.date.title" with the text "Date"
    And the JSON response should have "$.dimensions.date.value.title" with the text "December 2013"
    And the JSON response should have "$.dimensions.product.title" with the text "Producer product"
    And the JSON response should have "$.dimensions.product.value.title" with the text "7229110080: Alcoholic Beverages - SPECIAL INDEX FOR USE IN NSO - Manu incl duty"
    And the JSON response should have "$.measures[0].title" with the text "Price Index"

  Scenario: fetch a slice of observations
    Given several observations exist in the database
    When I visit the URL for querying observations with field "product" and value "mc6a"
    Then the response status should be "200"
    And the response content type should be JSON
    And the JSON response should have "$[0].product" with the text "MC6A"