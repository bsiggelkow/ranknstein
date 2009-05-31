require 'rubygems'
require 'sinatra'
require 'haml'
require File.dirname(__FILE__) + '/ranker'

get '/' do
  'Welcome to RankNStein!'
end
