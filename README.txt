= Capistrano Mailer v2.0.1 =
=== For Capistrano Deployment Email Notification ===

== It is a Capistrano Plugin AND a Rails Plugin ==

Ever wanted to be emailed whenever someone on the team does a cap deploy of trunk or some tag to some server.  
Wouldn't it be nice to know about it every time a release was deployed?  For large rails projects this type of coordination is essential, 
and this plugin makes sure everyone on the need to know list is notified when something new is deployed.

This plugin is an extension to Capistrano.

That means it registers itself with Capistrano as a plugin and is therefore available to call in your recipes.

If you are looking to roll your own email integration into capistrano then try this pastie:
http://pastie.org/146264 (thanks to  	 	
Mislav Marohnić).
But if you want to take the easy road to riches then keep reading ;)
 -- figurative "riches" of course, I promise nothing in return for your using this plugin

== Home Page ==

http://code.google.com/p/capistrano-mailer/


== Requirements ==

==== at least Rails 2.0.2 (might work with rails as old as 1.2.x) ====

==== at least Capistrano 2.4.3 (might work with capistrano as old as 2.1.0) ====

== Installation ==

./script/plugin install http://capistrano-mailer.googlecode.com/svn/trunk/capistrano_mailer


== Usage ==

==== 1. Install the plugin. ====

==== 2. Add this line to the top of your deploy.rb: ====

require 'vendor/plugins/capistrano_mailer/lib/capistrano_mailer'

==== 3. Add a cap_mailer_settings.rb file to your config/ directory: ====

require 'vendor/plugins/capistrano_mailer/lib/cap_mailer'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = { 
  :address        => "mail.default.com", 
  :port           => 25, 
  :domain         => 'default.com', 
  :perform_deliveries => true,
  :user_name      => "releases@default.com", 
  :password       => "mypassword", 
  :authentication => :login }
ActionMailer::Base.default_charset = "utf-8"# or "latin1" or whatever you are using

CapMailer.template_root = "vendor/plugins/capistrano_mailer/views/"
CapMailer.recipient_addresses = ["dev1@default.com"]
CapMailer.sender_address = %("Capistrano Deployment" <releases@default.com>)
CapMailer.email_prefix = "[MYSITE-CAP-DEPLOY]"
CapMailer.site_name = "MySite.com"
CapMailer.email_content_type = "text/html" # OR "text/plain" if you want the plain text version of the email

==== 4. Add these two tasks to your deploy.rb: ====

namespace :show do
  desc "Show some internal Cap-Fu: What's mah NAYM?!?"
  task :me do
    set :task_name, task_call_frames.first.task.fully_qualified_name
    puts "Running #{task_name} task"
  end
end

namespace :deploy do
  ...
  
  desc "Send email notification of deployment (only send variables you want to be in the email)"
  task :notify, :roles => :app do
    show.me
    mailer.send([
                      :rails_env => rails_env, 
                      :host => host, 
                      :task_name => task_name, 
                      :application => application,
                      :repository => repository,
                      :scm => scm,
                      :deploy_via => deploy_via,
                      :deploy_to => deploy_to,
                      :revision => revision,
                      :real_revision => real_revision,
                      :release_name => release_name,
                      :version_dir => version_dir,
                      :shared_dir => shared_dir,
                      :current_dir => current_dir,
                      :releases_path => releases_path,
                      :shared_path => shared_path,
                      :current_path => current_path,
                      :release_path => release_path,
                      :releases => releases,
                      :current_release => current_release,
                      :previous_release => previous_release,
                      :current_revision => current_revision,
                      :latest_revision => latest_revision,
                      :previous_revision => previous_revision,
                      :run_method => run_method,
                      :latest_release => latest_release,
                ],[   # Send some custom vars you've setup in your deploy.rb to be sent out with the notification email!
                			# will be rendered as a section of the email called 'Release Data'
                      #:some_other_var1 => some_other_var1,
                      #:some_other_var2 => some_other_var2,
                      #:some_other_var3 => some_other_var3
                ],[   # Send some more custom vars you've setup in your deploy.rb to be sent out with the notification email!
                			# will be rendered as a section of the email called 'Extra Information'
                      #:some_other_var4 => some_other_var4,
                      #:some_other_var5 => some_other_var5,
                      #:some_other_var6 => some_other_var6
                ],[ # and even more!!!
                		# these will not be rendered as a section, but will be passed to the email template in the @data hash, 
                		# and be available there if you want to write your own template
                ]
              )
  end

  ...
end

Make _sure_ you've defined `rails_env`, `repository`, `deploy_to`, `host`, and `application`.
task_name is defined by the show:me task above, and the others are defined behind the scenes by Capistrano!

The only parameter to mailer.send that is *required* is the first array of hashes, and _minimally_ it needs the keys:
 :rails_env
 :repository
 :task_name (provided by the show:me task included in this readme)
 :deploy_to
 :host
 :application

If anyone has a cool way of recording the *output* into a capistrano accessible variable, 
so that it can be shoved into the release email that would be an excellent contribution!

==== 5. Then add the hook somewhere in your deploy.rb: ====

after "deploy", "deploy:notify"

==== 6. Enjoy and Happy Capping! ====

==== 7. Customization ====

If you want to use your own views you'll need to recreate the notification_email view:
First you need to define where your templates are:
CapMailer.template_root = "app/views/capistrano_mailer/"

Then you'll need to create templates there called:
	notification_email.text.html.erb
and / or
	notification_email.text.plain.erb

Take a look at the templates that comes with the plugin to see how it is done (vendor/plugins/capistrano_mailer/views/notification_email...)

==== 8. For Rails 2.1 apps ====

You may want to add this inside your initializer

  config.gem 'capistrano',
      :version => '2.4.3',
      :lib => 'capistrano'


----------------------------------------------------------------------------------
	This plugin is a creation of Sagebit, LLC. (http://www.sagebit.com)

	Author: Peter Boling, peter.boling at gmail dot com

	Copyright (c) 2007-8 Sagebit LLC, released under the MIT license