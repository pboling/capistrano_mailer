Gem::Specification.new do |s|
  s.name = 'capistrano_mailer'
  s.version = '3.1.0'
  s.date = '2009-09-24'
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.summary = %q{Sends emails when Capistrano is used to do things!}
  s.description = %q{Useful for tracking deployment of websites to staging and production servers by a team of developers!}

  s.authors = ['Peter Boling']
  s.email = 'peter.boling@gmail.com'
  s.homepage = 'http://github.com/pboling/capistrano_mailer'
  s.require_paths = ["lib"]

  s.has_rdoc = true

  s.add_dependency 'rails', ['>= 2.1']

  s.files = ["MIT-LICENSE",
             "README.rdoc",
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


  s.test_files = []

end
