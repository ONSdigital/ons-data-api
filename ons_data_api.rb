require 'sinatra'
require 'oj'
require 'thin'
require 'mongoid'
require 'rack/conneg'

Dir.glob("#{File.dirname(__FILE__)}/lib/**/*.rb").sort.each do |file|
  require file
end

require_relative 'lib/presenters/observation_presenter'
require_relative 'lib/presenters/result_set_presenter'
require_relative 'lib/presenters/series_presenter'

require 'ons_data_models/require_all'

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

  get '/hello' do
    respond_to do |wants|
      wants.json { Oj.dump 'hello' => 'what up?' }
      wants.other { error_406 }
    end
  end

  get '/series' do
    series = {}
    Series.all.each do |s|
      series[s.slug] = SeriesPresenter.new(s).present
    end

    respond_to do |wants|
      wants.json { Oj.dump series }
      wants.other { error_406 }
    end
  end
  
  get '/series/:series' do
    series = Series.where(:slug => params[:series]).first
    respond_to do |wants|
      wants.json { Oj.dump SeriesPresenter.new(series).present }
      wants.other { error_406 }
    end    
  end  
  
  get '/series/:series/releases' do
    series = Series.where(:slug => params[:series]).first
    releases = {}
    series.releases.each do |r|
      releases[r.slug] = ReleasePresenter.new(r).present
    end  
    
    respond_to do |wants|
      wants.json { Oj.dump releases }
      wants.other { error_406 }
    end    
  end  
    
  get '/series/:series/releases/:release' do
    release = Release.where(:slug => params[:release]).first
    respond_to do |wants|
      wants.json { Oj.dump ReleasePresenter.new(release).present }
      wants.other { error_406 }
    end    
  end  
  
  get '/series/:series/releases/:release/datasets' do
    release = Release.where(:slug => params[:release]).first
    datasets = {}
    release.datasets.each do |d|
      datasets[d.slug] = DatasetPresenter.new(d).present
    end
    
    respond_to do |wants|
      wants.json { Oj.dump datasets }
      wants.other { error_406 }
    end    
  end  
  
  get '/series/:series/releases/:release/datasets/:dataset' do
    dataset = Dataset.where(:slug => params[:dataset]).first
    respond_to do |wants|
      wants.json { Oj.dump DatasetPresenter.new(dataset).present }
      wants.other { error_406 }
    end    
  end

  get '/series/:series/releases/:release/datasets/:dataset/observations' do
    dataset = Dataset.where(:slug => params[:dataset]).first
    allowed_params = dataset.available_dimension_names
    filtered_params = params.map do |field_name, value|
      if allowed_params.include?(field_name)
        # our data for PPI have uppercase values
        # hack this in here for moment ;(
        [field_name, value.upcase]
      end
    end
    # TODO: need paginated results in here
    # If you just hit obersavtions.json with no params, it'll time out trying
    # to render all thousands of them
    data_slice_params = filtered_params.compact
    observations = dataset.get_all_observations_with(data_slice_params.to_h)

    respond_to do |wants|
      wants.json { Oj.dump ResultSetPresenter.new(dataset, observations).present }
      wants.other { error_406 }
    end
  end

  get '/series/:series/releases/:release/datasets/:dataset/observations/:observation' do
    obs = Observation.where(:slug => params[:observation]).first
    obs_presented = ObservationPresenter.new(obs).present
    obs_presented["dataset"] = DatasetPresenter.new(obs.dataset).present
    respond_to do |wants|
      wants.json { Oj.dump obs_presented }
      wants.other { error_406 }
    end
  end

  def error_406
    content_type 'text/plain'
    error 406, "Not Acceptable" 
  end
  
end
