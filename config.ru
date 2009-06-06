require 'app/ranknstein'

Sinatra::Application.set(
  :run => false,
  :environment => :production
)
 
run Sinatra::Application