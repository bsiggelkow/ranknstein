# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'app', 'ranknstein'))

require 'rake'
require 'rspec/core/rake_task'

#COMMON_SPECS = FileList['spec/**/*_spec.rb']

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec) do |t|
#  t.rspec_opts = ['--options', "\"spec/spec.opts\""]
#  t.files = COMMON_SPECS
end
