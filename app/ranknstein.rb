require 'sinatra/base'
require_relative 'ranker'

class Ranknstein < Sinatra::Base

  set :public, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/views'
  
  # Usage: partial :foo => renders _foo.haml
  helpers do
    def partial(page, options={})
      haml page, options.merge!(:layout => false)
    end
  end

  get '/' do
    haml :index
  end

  get '/rank' do
    query = params['query']
    url = params['url']
    redirect '/' unless (query && !query.empty?) && (url && !url.empty?)

    ranker = Ranker.new(query, url)
    rank, result = ranker.rank
    haml :rank, :locals => {:rank => rank, :result => result, :query => query}
  end

  get '/faq' do
    haml :faq
  end

end