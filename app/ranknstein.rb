require 'rubygems'
require 'sinatra'
require 'haml'
require 'app/ranker'

get '/' do
  haml :index
end

get '/rank' do
  query = params['query']
  url = params['url']
  
  ranker = Ranker.new(query, url)
  rank, result = ranker.rank
  haml :rank, :locals => {:rank => rank, :result => result, :query => query}
end
