# -*- encoding: utf-8 -*-
require File.expand_path('../lib/capistrano_mailer/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "capistrano_mailer"
  s.version = CapistranoMailer::VERSION

  s.authors = ["Peter Boling", "Dave Nolan", "Jason Rust"]
  s.description = "Capistrano Deployment Email Notification.  Keep the whole team informed of each release!"
  s.email = ["peter.boling@gmail.com", "dave@textgoeshere.org.uk", "jason@rustedcode.com"]

  s.files         = Dir.glob("{assets,bin,lib,test,spec,features,views}/**/*") + %w(LICENSE README.md CHANGELOG.md Rakefile)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.extra_rdoc_files = [
    "CHANGELOG.md",
    "LICENSE",
    "README.md"
  ]

  s.homepage = "http://github.com/pboling/capistrano_mailer"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Capistrano Deployment Email Notification"

  s.add_runtime_dependency(%q<capistrano-log_with_awesome>, [">= 0"])
  s.add_runtime_dependency(%q<inline-style>, [">= 0"])
  s.add_runtime_dependency(%q<actionmailer>, [">= 0"])

end

