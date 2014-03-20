require 'coveralls'
Coveralls.wear!

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'ons_data_api.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'cucumber/api_steps'
require 'database_cleaner'
require 'database_cleaner/cucumber'

DatabaseCleaner.strategy = :truncation

Capybara.app = OnsDataApi

class OnsDataApiWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
  
  def app
    OnsDataApi
  end
end

World do
  OnsDataApiWorld.new
end
