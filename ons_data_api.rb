require 'sinatra'
require 'oj'
require 'mongoid'

Mongoid.load!(File.expand_path("mongoid.yml", File.dirname(__FILE__)), ENV['RACK_ENV'])

class OnsDataApi < Sinatra::Base

  get '/hello.json' do
    Oj.dump 'hello' => 'what up?'
  end

end