require 'sinatra'
require 'oj'

get '/hello.json' do
  Oj.dump 'hello' => 'what up?'
end
