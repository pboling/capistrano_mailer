class CapMailer < ActionMailer::Base
  
  @@sender_address = %("Capistrano Deployment" <capistrano@default.com>)
  cattr_accessor :sender_address

  @@recipient_addresses = []
  cattr_accessor :recipient_addresses

  @@email_prefix = "[DEPLOYMENT]-[#{ENV['RAILS_ENV']}]"
  cattr_accessor :email_prefix

  @@site_name = ""
  cattr_accessor :site_name

  @@sections = %w(deployment release_data source_control latest_release previous_release other_deployment_info extra_information)
  cattr_accessor :sections

  @@email_content_type = "text/html"
  cattr_accessor :email_content_type

  def self.reloadable?; false; end

  def notification_email(cap_vars, release_data = {}, extra_information = {}, data = {})
    date = Date.today.to_s
    time = Time.now.strftime("%I:%M %p").to_s
    inferred_command = "cap #{cap_vars.first[:rails_env]} #{cap_vars.first[:task_name]}"
    repo = cap_vars.first[:repository]
    x = repo.rindex('/') - 1
    front = repo.slice(0..x)
    back = repo.sub(front, '')
    unless back == 'trunk'
      x = front.rindex('/') - 1
      front = front.slice(0..x)
    end
    repo_end = repo.sub(front, '')
    
    subject       "#{self.email_prefix}[#{cap_vars.first[:rails_env].upcase}][#{repo_end}] #{inferred_command}"
    recipients    self.recipient_addresses
    from          self.sender_address
    content_type  self.email_content_type

    body       data.merge({
                  :section_data => {
                    :deployment => 
                      {
                        :date => date,
                        :time => time,
                        :rails_env => cap_vars.first[:rails_env], 
                        :task_name => cap_vars.first[:task_name], 
                        :inferred_command => inferred_command,
                        :host => cap_vars.first[:host], 
                        :release_name => cap_vars.first[:release_name]
                      },
                    :source_control =>
                      {
                        :revision => cap_vars.first[:revision],
                        :released => repo_end,
                        :repository => cap_vars.first[:repository],
                        :scm => cap_vars.first[:scm],
                        :deploy_via => cap_vars.first[:deploy_via],
                        :deploy_to => cap_vars.first[:deploy_to]
                      },
                    :latest_release =>
                      {
                        :latest_release => cap_vars.first[:latest_release],
                        :latest_revision => cap_vars.first[:latest_revision],
                        :release_path => cap_vars.first[:release_path],
                        :real_revision => cap_vars.first[:real_revision],
                        :current_path => cap_vars.first[:current_path]
                      },
                    :previous_release =>
                      {
                        :current_release => cap_vars.first[:current_release],
                        :current_revision => cap_vars.first[:current_revision],
                        :previous_release => cap_vars.first[:previous_release],
                        :previous_revision => cap_vars.first[:previous_revision],
                        :releases => cap_vars.first[:releases]
                      },
                    :other_deployment_info =>
                      {
                        :version_dir => cap_vars.first[:version_dir],
                        :shared_dir => cap_vars.first[:shared_dir],
                        :current_dir => cap_vars.first[:current_dir],
                        :releases_path => cap_vars.first[:releases_path],
                        :shared_path => cap_vars.first[:shared_path],
                        :run_method => cap_vars.first[:run_method],
                        :ip_address => cap_vars.first[:ip_address]
                      },
                    :release_data => release_data,
                    :extra_information => extra_information
                  },
                  :date => date,
                  :time => time,
                  :task_name => cap_vars.first[:task_name], 
                  :inferred_command => inferred_command,
                  :repo_end => repo_end,
                  :site_name => self.site_name,
                  :application => cap_vars.first[:application],
                  :sections => self.sections
              })
  end

end
