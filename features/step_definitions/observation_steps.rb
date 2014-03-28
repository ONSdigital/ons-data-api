Given(/^an observation exists in the database$/) do
  options = {
    price_index: 111.5,
    slug: 'abc123'
  }
  @observation = FactoryGirl.create :observation, options
end

Given(/^several observations exist in the database$/) do
  price_index = 100
  dates = ["2014", "2013"]
  obs = FactoryGirl.create(:observation, {date: "2012"})
  @dataset = obs.dataset
  @release = @dataset.release
  @series = @release.series

  @observations = dates.each_index do |index|
    price_index = price_index + 10
    options = {
      dataset: @dataset,
      price_index: price_index,
      slug: "an-slug-#{index}",
      date: dates[index],
      provisional: false
    }
    obs = FactoryGirl.create :observation, options
  end
end

When(/^I visit the URL for that observation$/) do
  steps %{
    When I send a GET request to "/series/series-slug/releases/release-slug/datasets/dataset-slug/observations/#{@observation.slug}"
  }
end

When(/^I visit the URL for querying observations with field "(.*?)" and value "(.*?)"$/) do |field_name, value|
  steps %{
    When I send a GET request to "/series/#{@series.slug}/releases/#{@release.slug}/datasets/#{@dataset.slug}/observations.json?#{field_name}=#{value}"
  }
end
