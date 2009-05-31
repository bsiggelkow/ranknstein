require File.expand_path(File.dirname(__FILE__)+'/../../spec/spec_helper')
require 'webrat'

Webrat.configure do |config|
  config.mode = :rack_test
end

set :environment, :test

World do
  def app
    Sinatra::Application
  end
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
end

