# I use this to make life easier when installing and testing from source:
rm -rf capistrano_mailer-*.gem && gem build capistrano_mailer.gemspec && sudo gem uninstall capistrano_mailer && sudo gem install capistrano_mailer-0.2.0.gem --no-ri --no-rdoc
