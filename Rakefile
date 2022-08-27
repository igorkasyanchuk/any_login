begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AnyLogin'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../test/rails_apps/devise/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

load 'rails/tasks/statistics.rake'

Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test_devise) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = ['test/devise/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new(:test_authlogic) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = ['test/authlogic/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new(:test_clearance) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = ['test/clearance/**/*_test.rb']
  t.verbose = false
end

Rake::TestTask.new(:test_sorcery) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = ['test/sorcery/**/*_test.rb']
  t.verbose = false
end
