# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "capistrano_mailer"
  s.version = "4.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Boling", "Dave Nolan", "Jason Rust"]
  s.date = "2011-12-11"
  s.description = "Capistrano Deployment Email Notification.  Keep the whole team informed of each release!"
  s.email = ["peter.boling@gmail.com", "dave@textgoeshere.org.uk", "jason@rustedcode.com"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.homepage = "http://github.com/pboling/capistrano_mailer"
  s.rubygems_version = "1.8.10"
  s.summary = "Capistrano Deployment Email Notification"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionmailer>, [">= 0"])
    else
      s.add_dependency(%q<actionmailer>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionmailer>, [">= 0"])
  end

  s.add_dependency "inline-style"
  s.add_dependency "capistrano-log_with_awesome"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

