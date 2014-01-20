require 'capistrano_mailer/version'

require 'capistrano'

unless Capistrano::Configuration.respond_to?(:instance)
  abort 'capistrano/mailer requires Capistrano 2'
end

require 'capistrano/log_with_awesome'
require 'inline-style'
require 'action_mailer'

require 'cap_mailer'

module Capistrano
  class Configuration
    module CapistranoMailer
      def send_notification_email(cap, config = {}, *args)
        CapMailer.notification_email(cap, config, *args).deliver
      end
    end

    include CapistranoMailer

    module Execution
      protected
        def __rollback_with_mailer!
          set :mailer_status, :failure
          find_and_execute_task "deploy:notify"
          __rollback_without_mailer!
        end

        alias_method :__rollback_without_mailer!, :rollback!
        alias_method :rollback!, :__rollback_with_mailer!
    end
  end
end

Capistrano.plugin :mailer, Capistrano::Configuration::CapistranoMailer

if cap = Capistrano::Configuration.instance
  cap.load("#{File.expand_path(File.dirname(__FILE__))}/mailer_recipes.rb")
end
