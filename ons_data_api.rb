require 'sinatra'
require 'oj'
require 'mongoid'
require 'ons_data_models/require_all'
require 'rack/conneg'

require 'presenters/observation_presenter'

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

  get '/series/release/dataset/:observation' do
    obs = Observation.where(:slug => params[:observation]).first
    respond_to do |wants|
      wants.json { Oj.dump ObservationPresenter.new(obs).present }
      wants.other { error_406 }
    end
    
  end

  def error_406
    content_type 'text/plain'
    error 406, "Not Acceptable" 
  end
  
end