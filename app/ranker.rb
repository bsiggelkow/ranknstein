require 'ruby-web-search'

class Array
  # We don't need this monkey patch in Ruby >=1.8.7'
  def find_index(&block)
    self.each_with_index do |item, index|
      return index if yield(item)
    end
    nil
  end
end
  
class Ranker
  attr_accessor :query, :url
  def initialize(query, url)
    @query = query
    @url = url
  end
  
  def rank
    response = RubyWebSearch::Google.search(:query => query, :size => 500)
    results = response.results
    index = results.find_index { |result| result[:url] == url }
    index ? index + 1 : nil
  end
end