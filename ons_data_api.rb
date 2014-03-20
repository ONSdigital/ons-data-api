require 'sinatra'
require 'oj'

class OnsDataApi < Sinatra::Base

  get '/hello.json' do
    Oj.dump 'hello' => 'what up?'
  end

end