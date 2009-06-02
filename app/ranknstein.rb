require 'rubygems'
require 'sinatra'
require 'haml'
require File.dirname(__FILE__) + '/ranker'

get '/' do
  haml :index
end

get '/rank' do
  query = params['query']
  url = params['url']
  
  ranker = Ranker.new(query, url)
  rank = ranker.rank
  puts "Rank: #{rank}"
  haml :rank, :locals => {:rank => rank}
end
