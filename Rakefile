require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "textgoeshere-capistrano_mailer"
    gemspec.summary = "Fork of Capistrano Deployment Email Notification"
    gemspec.description = %q{Fork of Capistrano Deployment Email Notification.  Keep the whole team informed of each release!}
    gemspec.email = "dave@textgoeshere.org.uk"
    gemspec.homepage = "http://github.com/textgoeshere/capistrano_mailer"
    gemspec.authors = ["Peter Boling", "Dave Nolan"]
    gemspec.add_dependency 'actionmailer'
    gemspec.files = ["README.rdoc",
             "capistrano_mailer.gemspec",
             "init.rb",
             "about.yml",
             "lib/cap_mailer.rb",
             "lib/capistrano/mailer.rb",
             "Rakefile",
             "views/cap_mailer/_section.html.erb",
             "views/cap_mailer/_section.text.erb",
             "views/cap_mailer/_section_custom.html.erb",
             "views/cap_mailer/_section_custom.html.erb",
             "views/cap_mailer/notification_email.text.html.erb",
             "views/cap_mailer/notification_email.text.plain.erb",
             "VERSION.yml"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
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
