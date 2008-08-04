require 'rubygems' unless defined?(Rubygems)
require 'capistrano' unless defined?(Capistrano)
require 'action_mailer' unless defined?(ActionMailer)
require 'config/cap_mailer_settings'

module CapistranoMailer
  def send(cap_vars, extra = {}, data = {})
    CapMailer.deliver_notification_email(cap_vars, extra, data)
  end
end

Capistrano.plugin :mailer, CapistranoMailer
