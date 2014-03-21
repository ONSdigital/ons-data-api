Feature:  
  In order to get basic values out of the data API
  As an API client
  I want to be able to fetch series

  Background:
    Given I send and accept JSON
  
  Scenario: fetch a single series
    Given an series exists in the database
    When I visit the URL for that series
    Then the response status should be "200"
    And the response content type should be JSON
    And the JSON response should have "$.title" with the text "PPI Statistical Bulletin"
    And the JSON response should have "$.description" with the text "A description of this series"