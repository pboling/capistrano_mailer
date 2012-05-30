require 'rake'
require 'rake/testtask'
require 'rdoc/task'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "capistrano_mailer"
    gemspec.summary = "Capistrano Deployment Email Notification"
    gemspec.description = %q{Capistrano Deployment Email Notification.  Keep the whole team informed of each release!}
    gemspec.email = ["peter.boling@gmail.com", "dave@textgoeshere.org.uk", "jason@rustedcode.com"]
    gemspec.homepage = "http://github.com/pboling/capistrano_mailer"
    gemspec.authors = ["Peter Boling", "Dave Nolan", "Jason Rust"]
    gemspec.add_dependency 'actionmailer'
    gemspec.files = `git ls-files`.split("\n")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the capistrano_mailer gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the capistrano_mailer gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'capistrano_mailer'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.markdown')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
