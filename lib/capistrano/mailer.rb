require 'rubygems' unless defined?(Rubygems)
require 'capistrano' unless defined?(Capistrano)
require 'action_mailer' unless defined?(ActionMailer)
require 'cap_mailer'

# ActionMailer configuration in the rails app
require 'config/cap_mailer_settings'

unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano/mailer requires Capistrano 2"
end

module Capistrano
  class Configuration
    module CapistranoMailer
      def send_notification_email(cap_vars, extra = {}, data = {})
        CapMailer.deliver_notification_email(cap_vars, extra, data)
      end
    end

    include CapistranoMailer
  end
end

Capistrano.plugin :mailer, Capistrano::Configuration::CapistranoMailer
