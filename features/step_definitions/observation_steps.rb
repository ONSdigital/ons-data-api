Given(/^an observation exists in the database$/) do
  options = {
    price_index: 111.5,
    slug: 'abc123'
  }
  @observation = FactoryGirl.create :observation, options
end

When(/^I visit the URL for that observation$/) do
  steps %{
    When I send a GET request to "/series/series-slug/releases/release-slug/datasets/dataset-slug/observations/#{@observation.slug}"
  }
end
