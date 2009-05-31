require File.dirname(__FILE__) + '/../spec_helper'

describe Ranker do
  before do
    @valid_results = [
      {
        :url       => "http://billsiggelkow.com/", 
        :title     => "Home by BillSiggelkow.com", 
        :cache_url =>"http://www.google.com/search?q=cache:BlGCHJLCx-cJ:billsiggelkow.com", 
        :content   =>"<b>Bill&#39;s</b> Tweeting His iPOD A to Z! July 11th, 2008. Posted by bsiggelkow in <b>...</b>   About Me. AIM: siggelkowb. \302\251 <b>Bill Siggelkow</b>, 2008.", 
        :domain    =>"billsiggelkow.com"
      }, 
      { 
        :url       =>"http://www.oreillynet.com/cs/catalog/view/au/1895", 
        :title     =>"Bill Siggelkow", 
        :cache_url =>"http://www.google.com/search?q=cache:GJgvBa-MuQ0J:www.oreillynet.com", 
        :content   =>"<b>Bill Siggelkow</b> is an independent consultant specializing in software design,   development, and technical training.", 
        :domain    =>"www.oreillynet.com"
      }, 
      {
        :url       =>"http://www.amazon.com/Jakarta-Struts-Cookbook-Bill-Siggelkow/dp/059600771X", 
        :title     =>"Amazon.com: Jakarta Struts Cookbook: Bill Siggelkow: Books", 
        :cache_url =>"http://www.google.com/search?q=cache:kZkaJZqNeVsJ:www.amazon.com", 
        :content   =>"<b>Bill Siggelkow</b> is an independent consultant specializing in software design,   <b>....</b> 4.0 out of 5 stars Good Struts meal cooked by <b>Bill Siggelkow</b> <b>...</b>", 
        :domain    =>"www.amazon.com"
      }, 
      {
        :url       =>"http://jadecove.com/", 
        :title     =>"Jade Cove Solutions", 
        :cache_url =>"http://www.google.com/search?q=cache:pD76k6DpVHQJ:jadecove.com", 
        :content   =>"<b>Bill Siggelkow</b>, Jade Cove&#39;s founder and principal engineer has well over 20   years of <b>...</b> Jade Cove Solutions was founded and is led by <b>Bill Siggelkow</b>. <b>...</b>", 
        :domain    =>"jadecove.com"
      }
    ]
  end
  it "should return the index of a matching result" do
    query = 'bill siggelkow'
    url   = 'http://jadecove.com/'
    ranker = Ranker.new(query, url)
    RubyWebSearch::Google.should_receive(:search).with({:query => query, :size => 500}).and_return(mock('response', :results => @valid_results))
    ranker.rank.should == 4
  end
  it "should return nil if no matching result" do
    query = 'bill siggelkow'
    url   = 'http://example.com/'
    ranker = Ranker.new(query, url)
    RubyWebSearch::Google.should_receive(:search).with({:query => query, :size => 500}).and_return(mock('response', :results => @valid_results))
    ranker.rank.should be_nil
  end
end
