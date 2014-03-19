## Version 3.3.0 2014-03-17
* Fix compatibility with Rails 2.3.18
* Add tests with rspec and capistrano-spec
* Integrate Travis-ci
* Integrate Coveralls
* Backport (most) new features from master (4.X releases)
  * Gemfile.lock should not be in version control for a gem by Peter Boling
  * Do not require RubyGems by Peter Boling
  * Fix dependency declarations; remove jeweler dependency; improve gemspec by Peter Boling
  * Modernize the ruby manager by Peter Boling
  * Modernize the VERSION by Peter Boling
  * Markdown the Readme. by Peter Boling (pboling)
  * Modern the License by Peter Boling (pboling)
  * Markdown the Changelog by Peter Boling (pboling)
  * Git Release Notes by Mark Sim (marksim)
  * Improved Readme by Peter Boling (pboling)

## Version 3.2.7 2011-12-11
* General file cleanup
* Improved Readme
* Fix to \*args passing to CapMailer.deliver_notification_email (dreamnid)

## Version 3.2.6 --botched--

## Version 3.2.5 2010-04-29
* Remove Active Support dependency

## Version 3.2.4 2010-01-13
* Fixed subject line format (mail client filters are based on format of subject line)

## Version 3.2.3 2010-01-13
* config[:user] is now optional.

## Version 3.2.2 2010-01-13
* Improved Readme

## Version 3.2.1 2010-01-13
* Added deprecation warning for configure_capistrano_mailer
* commented :site_url, doesn't appear to be a native capistrano variable, if sent in will still be rendered.

## Version 3.2.0 textgoeshere fork
* config/cap_mailer_settings.rb is not longer a hard coded configuration location requirement.
* refactoring core cap mailer class

## Version 3.1.10 2010-01-07
* included \_section.text.erb view in gem manifest
* text version of email should render the text partials, not html

## Version 3.1.9 2010-01-07
* Fixed URL for capistrano_mailer repo on github in HTML email message

## Version 3.1.8 2010-01-07
* Improved Readme

## Version 3.1.6 2009-11-10
* Fixed installation instructions to reference gemcutter instead of github

## Version 3.1.3 2009-09-29
* Added Git as known compatable SCM to readme
* Credited Dustin Deyoung as Author of HTML Email templates
* Removed MIT-LICENSE file from gemspec (because github refuses to build with it there)
* Still trying to get github to build the gem

## Version 3.1.2 2009-09-25
* Fixed footer copyright
* Trying to get github to build the gem

## Version 3.1.1 2009-09-24
* Added back compatability with svn which broke when fixing for perforce (thanks to Matthew Beale / mixonic)
* Improved Readme for plugin installation.  Tested as a plugin.  Verified continued compatibility with Deprec.

## Version 3.1.0 2009-09-17
* Added compatability with perforce (thanks to Andy Kock / ak47)

## Version 3.0.3 2009-09-03
* Improved readme and upgrade instructions

## Version 3.0.2 2009-08-27
* Fixed some typos in readme referencing outdated API

## Version 3.0.1 2009-08-21
* removed a stray puts used in debugging

## Version 3.0.0 2009-08-19
* turned into a gem
* New API for configuration
* improved email templates (hardened against crappy data)
* added simple testing framwork and Rakefile
* still compatible with deprec

## Version 2.1.0 2008-11-15
* improved readme, and other stuff I don't remember

## Version 2.0.1 2008-07-30
* Works when deploying to a server without capistrano installed
* Updated README and WIKI (improved documentation)

## Version 2.0 2008-07-25
* Works with Rails 2.1
* Works with Capistrano 2.4.3
* Added access to many of Capistrano's internal variables (~25) so the emails can be more informative
* Added inferred_command, repo_end and some other derived variables that give more insight into a deployment
* Parameters are now sent in a hash
* Emails updated with new information
* HTML email improved layout, and added styling (thanks to Dustin Deyoung @ Sagebit)

## Version 1.0.1 2008-03-26
* Works with Rails 2.0.2
* Works with Capistrano 2.1.0 - 2.2.0
* Compatability with Deprec verified

## Version 1.0 2008-02-11
* Works with Rails 2.0.2
* Works with Capistrano 2.1.0
