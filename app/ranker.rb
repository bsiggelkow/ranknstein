require 'rubygems'
require 'net/http'
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
  attr_accessor :query, :url, :fuzzy
  def initialize(query, url, fuzzy=true)
    @query = query
    @url = normalize(url)
    @fuzzy = fuzzy
    @fuzzy_matcher = build_fuzzy_matcher if fuzzy
    @results = []
  end
  
  def rank
    results
    find_match
  end

  private 
  def results
    # Google will not return more than 64 total results (8 responses x 8 cursors)
    response = RubyWebSearch::Google.search(:query => query, :size => 64)
    @results = response.results
  end

  # Find the index and value of the matching result
  def find_match
    if @results && !@results.empty?
      index = @results.find_index do |result| 
        fuzzy ? fuzzy_match(result[:url]) : exact_match(result[:url])
      end
      index ? [index + 1, @results[index]] : nil
    end
  end

  def fuzzy_match(_url)
    _url =~ @fuzzy_matcher
  end

  def exact_match(_url)
    _url == url
  end
    
  def build_fuzzy_matcher
    # append http if missing
    protocol_part = "https?://"
    www_part = "(www.)?"
    turl = url.dup
    turl.sub!(/^https?:\/\//,'')
    turl.sub!(/^www\./, '')
    url_re = "^#{protocol_part}#{www_part}#{turl}"
    Regexp.new(url_re)
  end

  def normalize(url)
    _url = URI.parse(url)
    _url.normalize!
    _url.to_s
  end
end