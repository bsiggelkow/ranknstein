unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))
  $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
end
require 'bundler/setup'
require 'app/ranknstein'

Sinatra::Application.set(
  :run => false,
  :environment => :production
)
 
run Sinatra::Application
