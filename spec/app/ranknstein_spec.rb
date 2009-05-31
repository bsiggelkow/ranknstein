require File.dirname(__FILE__) + '/../spec_helper'

set :environment, :test

describe 'Ranknstein' do
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end

  describe 'get /' do
    it 'should respond with success' do
      get '/'
      last_response.should be_ok
    end
    it 'should display a form for entering a query and url' do
      get '/'
      last_response.body.should =~ /<form/
    end
  end

end