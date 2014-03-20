require 'sinatra'
require 'oj'
require 'mongoid'
require 'rack/conneg'

Mongoid.load!(File.expand_path("mongoid.yml", File.dirname(__FILE__)), ENV['RACK_ENV'])

class OnsDataApi < Sinatra::Base

  use(Rack::Conneg) { |conneg|
    conneg.set :accept_all_extensions, false
    conneg.set :fallback, :html
    conneg.provide([:json])
  }

  before do
    if negotiated?
      content_type negotiated_type
    end
  end

  get '/hello.json' do
    Oj.dump 'hello' => 'what up?'
  end

end