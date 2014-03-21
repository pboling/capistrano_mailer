# CapistranoMailer

A Gem For Capistrano Deployment Email Notification

| Project                 |  Capistrano Mailer   |
|------------------------ | ----------------- |
| gem name                |  capistrano_mailer   |
| license                 |  MIT              |
| moldiness               |  [![Maintainer Status](http://stillmaintained.com/pboling/capistrano_mailer.png)](http://stillmaintained.com/pboling/capistrano_mailer) |
| version                 |  [![Gem Version](https://badge.fury.io/rb/capistrano_mailer.png)](http://badge.fury.io/rb/capistrano_mailer) |
| dependencies            |  [![Dependency Status](https://gemnasium.com/pboling/capistrano_mailer.png)](https://gemnasium.com/pboling/capistrano_mailer) |
| code quality            |  [![Code Climate](https://codeclimate.com/github/pboling/capistrano_mailer.png)](https://codeclimate.com/github/pboling/capistrano_mailer) |
| inline documenation     |  [![Inline docs](http://inch-pages.github.io/github/pboling/capistrano_mailer.png)](http://inch-pages.github.io/github/pboling/capistrano_mailer) |
| continuous integration  |  [![Build Status](https://travis-ci.org/pboling/capistrano_mailer.png?branch=rails2)](https://travis-ci.org/pboling/capistrano_mailer) |
| test coverage           |  [![Coverage Status](https://coveralls.io/repos/pboling/capistrano_mailer/badge.png)](https://coveralls.io/r/pboling/capistrano_mailer) |
| homepage                |  [https://github.com/pboling/capistrano_mailer][homepage] |
| documentation           |  [http://rdoc.info/github/pboling/capistrano_mailer/frames][documentation] |
| author                  |  [Peter Boling](https://coderbits.com/pboling) |
| Spread ~♡ⓛⓞⓥⓔ♡~      |  [![Endorse Me](https://api.coderwall.com/pboling/endorsecount.png)](http://coderwall.com/pboling) |

## Summary

  * It is a Capistrano Plugin / Ruby Gem that requires ActionMailer
  * It is MIT licensed
  * It is old, but still kicking; project started in 2007
  * rails2 branch (THIS BRANCH!), releases will be in 3.x range, requires Rails 2.X
  * master branch, releases will be in 4.x range, requires Rails 3.X
  * Requires at least Capistrano 2.4.3 (might work with capistrano as old as 2.1.0, but has not been tested)
  * Known to be compatible with SCMs as of version 3.1.2: Perforce, SVN, and Git
  * Known to be compatible with, but does not require, the deprec gem.

## About

Ever wanted to be emailed whenever someone on the team does a cap deploy of trunk or some tag to some server.
Wouldn't it be nice to know about it every time a release was deployed?  For large rails projects this type of coordination is essential,
and this plugin makes sure everyone on the need to know list is notified when something new is deployed.

This plugin/gem is an extension to Capistrano.

That means it registers itself with Capistrano as a plugin and is therefore available to call in your recipes.

If you are looking to roll your own email integration into capistrano then try this pastie:
http://pastie.org/146264 (thanks to Mislav Marohnić).
But if you want to take the easy road to riches then keep reading ;)
 -- figurative "riches" of course, I promise nothing in return for your using this plugin

### Important Note:

The first time you deploy to a server (a 'cold' deploy) capistrano mailer will cause an error because it uses capistrano's previous release variables, and when there are no previous releases capistrano throws an error.  In the next version this will be fixed, just don't have time at the moment.  If you would like to work on this 'first deploy' problem please fork my repo and work on it!

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano_mailer', '~> 3.3.0'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano_mailer

### With Rails <= 2.X (THIS BRANCH!)

The 3.x+ versions of this gem require Rails 2.X

### With Rails >= 3.X (NOT THIS BRANCH!)

Switch to the master branch (releases will be in 4+ range)
The 4.x+ versions of this gem require at least Rails 3

## Upgrading

From version 3.2.x to version 3.3.x

1. If you had customized mailer views you might need to update the name.
   The built-in views have been changed from with a `.text`:

    `notification_email.text.html.erb`

    to without

    `notification_email.html.erb`

From version 3.1.x to version 3.2.x

1. Update the way CapistranoMailer is configured using the new method: CapMailer.configure (see Usage below).
2. require the cap mailer config file (see Usage below)

From version 2.1.0 to version 3.1.x:

1. Update the way CapistranoMailer is configured using the new method: CapMailer.configure_capistrano_mailer (changed in later versions to just 'configure') (see Usage below).
2. Update the require statement at the top of deploy.rb, see below (note for plugin change from capistrano_mailer to capistrano/mailer).
3. Change the mailer.send to mailer.send_notification_email in your cap recipe.

## Usage

1) You need to have already setup capistrano in the project, including the 'capify .' command.

2) Load the Capistrano plugin: Add this line to the top of your config/deploy.rb:

    require 'capistrano/mailer'

    # configure capistrano_mailer
    # The configuration file can go anywhere, but in past versions of the gem it was required to be in the config/ dir.
    require 'config/cap_mailer_settings'

3) Configure Capistrano Mailer in the settings file required in step 2 (`config/cap_mailer_settings` or whatever you called it):

    ActionMailer::Base.delivery_method = :sendmail
    ActionMailer::Base.default_charset = "utf-8"
    ActionMailer::Base.sendmail_settings = {
      :location       => '/usr/sbin/sendmail',
      :arguments      => "-i -t -f deploy@example.com" # the address your deployment notification emails will come from
    }

    CapMailer.configure do |config|
      config[:recipient_addresses]  = ["dev1@example.com"]
      config[:sender_address]       = "deployment@example.com"
      config[:subject_prepend]      = "[EMPTY-CAP-DEPLOY]"
      config[:site_name]            = "Empty Example.com App"
    end

4) Setup the tasks.

    # load recipes for notification (or roll your own)
    require 'capistrano/mailer_recipes'

  OR: Roll your own! Add these two tasks to your deploy.rb:

    namespace :show do
      task :me do
        set :task_name, task_call_frames.first.task.fully_qualified_name
      end
    end

    namespace :deploy do
      desc "Send email notification of deployment"
      task :notify, :roles => :app do
        show.me  # this sets the task_name variable

        # Set the release notes
        git_commits_range = "#{previous_revision.strip}..#{current_revision.strip}"
        git_log = `git log --pretty=oneline --abbrev-commit #{git_commits_range}` # executes in local shell
        set :release_notes, git_log.blank? ? "No Changes since last deploy." : "from git:\n" + git_log

        # These are overridden by settings from configure the block:
        #   CapMailer.configure do |config|
        #     config[:attach_log_on] = [:failure]
        #   end
        mailer.send_notification_email(self, {
          #:attach_log_on => [:success, :failure],
          :release_notes => release_notes
        })
      end
    end


5) Make _sure_ you've defined `rails_env`, `repository`, `deploy_to`, `host`, and `application`.  `task_name` is defined by the show:me task above, and the others are defined behind the scenes by Capistrano!

6) The only parameter to mailer.send_notification_email that is *required* is the first, and it should always be `self`. _Minimally_ you need to define the capistrano variables:

    :rails_env
    :repository
    :task_name (provided by the show:me task included in this readme)
    :deploy_to
    :host
    :application

7) You can `set` any variable and send it to be rendered as a custom section in the notification email using the third parameter to `send_notification_email`:

        set :hot_slice_of_wonder, 'This is just so cool'

        mailer.send_notification_email(
          self, # will contain everything defined with set, but capistrano mailer will only know to pull some of them for rendering
          { :attach_log_on => [:success, :failure] }, # Custom configurations
          { :my_super_awesome_thing => hot_slice_of_wonder }
        )

8) Then add the hook somewhere in your deploy.rb (if you required `capistrano/mailer_recipes` this is already done):

    after "deploy", "deploy:notify"

9) Enjoy and Happy Capping!

## Customization

If you want to use your own views you'll need to recreate the notification_email view:
First you need to define where your templates are:

    CapMailer.configure_capistrano_mailer do |config|
      config[:template_root]      = "app/views/capistrano_mailer/"
    end

Then you'll need to create templates there called:

  `notification_email.html.erb`

and / or

  `notification_email.plain.erb`

Take a look at the templates that comes with the plugin to see how it is done (views/cap_mailer/...)

## Credit where Credit is Due

[Peter Boling (pboling)](https://github.com/pboling) - Wrote original & maintainer
[Dave Nolan (textgoeshere)](https://github.com/textgoeshere) - lots of refactoring for 3.2 release
[Jason Rust (jrust)](https://github.com/jrust) - Updated for Rails 3 compatibility

Thanks to [Dustin Deyoung (ddeyoung)](https://github.com/ddeyoung) for the beautiful HTML email templates.
Thanks to mixonix and [Yoan Blanc (greut)](https://github.com/greut) for work on SCMs compatibility

## How you can help!

Take a look at the `reek` list which is the file called `REEK` and stat fixing things.  Once you complete a change, run the tests:

```
bundle exec rake test:all
```

If the tests pass refresh the `reek` list:

```
bundle exec rake reek > REEK
```

Follow the instructions for "Contributing" below.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver].
Violations of this scheme should be reported as bugs. Specifically,
if a minor or patch version is released that breaks backward
compatibility, a new version should be immediately released that
restores compatibility. Breaking changes to the public API will
only be introduced with new major versions.

As a result of this policy, you can (and should) specify a
dependency on this gem using the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

    spec.add_dependency 'capistrano_mailer', '~> 0.5'

## License

* MIT License - See LICENSE file in this project
* Copyright (c) 2008-2014 [Peter H. Boling][peterboling] of [Rails Bling][railsbling]
* Copyright (c) 2007-8 Peter Boling & Sagebit, LLC

[semver]: http://semver.org/
[pvc]: http://docs.rubygems.org/read/chapter/16#page74
[railsbling]: http://www.railsbling.com
[peterboling]: http://www.peterboling.com
[documentation]: http://rdoc.info/github/pboling/capistrano_mailer/frames
[homepage]: https://github.com/pboling/capistrano_mailer

