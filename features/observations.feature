Feature:  
  In order to get basic values out of the data API
  As an API client
  I want to be able to fetch observations

Scenario: fetch a single observation
  Given an observation exists in the database
  When I visit the URL for that observation
  Then I should get a JSON response
  And that response should include "111.5"


