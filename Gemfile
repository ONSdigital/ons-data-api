source 'https://rubygems.org'

ruby '2.1.0'
#ruby-gemset=ons-data-api

gem 'sinatra', '1.4.4'
gem 'oj', '2.6.0'
gem 'rake'
gem 'rack-conneg'
gem 'ons_data_models', github: "ONSdigital/ons_data_models"

group :development, :test do
  
  gem 'capybara-webkit'
  gem 'cucumber-sinatra'
  gem 'coveralls', require: false
  gem 'cucumber-api-steps', require: false, github: 'theodi/cucumber-api-steps', branch: 'feature-test-content-type'
  gem 'database_cleaner'
  gem 'rspec'
  gem 'rack-test'
  gem 'guard'
  gem 'guard-cucumber'
  gem 'factory_girl'
  
end