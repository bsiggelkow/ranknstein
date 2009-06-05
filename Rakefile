# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'app', 'ranknstein'))

require 'rake'
require 'spec/rake/spectask'
# require 'rake/rdoctask'

COMMON_SPECS = FileList['spec/**/*_spec.rb']

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"spec/spec.opts\""]
  t.spec_files = COMMON_SPECS
end
