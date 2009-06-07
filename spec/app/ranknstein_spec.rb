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
    it 'should have a Google analytics tag' do
      get '/'
      last_response.body.should =~ /google\-analytics/
    end
  end

  describe 'get /rank' do
    describe 'with a valid query string' do
      def do_get
        @params = {'query' => 'foo', 'url' => 'bar.com'}
        @ranker =  mock('ranker')
        Ranker.stub!(:new).and_return(@ranker)
        @ranker.should_receive(:rank).and_return([1,{:url => 'bar.com'}])
        get '/rank', @params
      end
      it 'should respond with ok' do
        do_get
        last_response.should be_ok
      end
      it 'should have a Google analytics tag' do
        do_get
        last_response.body.should =~ /google\-analytics/
      end
    end
    describe 'with an invalid query string which' do
      def do_get
        get '/rank', @params
        last_response.should be_redirect
      end
      describe 'is empty' do
        before {@params = {}}
        it('should redirect to /') { do_get } 
      end
      describe "only has 'query'" do
        before {@params = {'query' => 'foo'}}
        it('should redirect to /') { do_get }
      end
      describe "only has 'url'" do
        before {@params = {'url' => 'foo.com'}}
        it('should redirect to /') { do_get }
      end
    end
  end

end