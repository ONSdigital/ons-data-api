Given(/^an series exists in the database$/) do
  options = {
    title: 'PPI Statistical Bulletin',
    slug: 'product-price-index'
  }
  @series = FactoryGirl.create :series, options
end

When(/^I visit the URL for that series$/) do
  steps %{
    When I send a GET request to "/#{@series.slug}"
  } 
end

Then(/^I should get a JSON response$/) do
  
end

Then(/^that response should include "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end