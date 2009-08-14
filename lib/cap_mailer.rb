class CapMailer < ActionMailer::Base

  @@config = {
    :sender_address           => %("#{(defined?(Rails) ? Rails.env.capitalize : defined?(RAILS_ENV) ? RAILS_ENV.capitalize : defined?(ENV) ? ENV['RAILS_ENV'] : "")} Capistrano Deployment" <capistrano.mailer@example.com>),
    :recipient_addresses      => [],
    # Customize the subject line
    :subject_prepend          => "[DEPLOYMENT]-[#{(defined?(Rails) ? Rails.env.capitalize : defined?(RAILS_ENV) ? RAILS_ENV.capitalize : defined?(ENV) ? ENV['RAILS_ENV'] : "")}] ",
    :subject_append           => nil,
    # Include which sections of the deployment email?
    :sections                 => %w(deployment release_data source_control latest_release previous_release other_deployment_info extra_information),
    # Only use this gem to render, never email
    :site_name                => "",
    :email_content_type       => "text/html",
    :template_root            => "#{File.dirname(__FILE__)}/../views"
  }

  cattr_accessor :config

  def self.configure_capistrano_mailer(&block)
    yield @@config
  end

  self.template_root = config[:template_root]

  def self.reloadable?() false end

  def notification_email(cap_vars, release_data = {}, extra_information = {}, data = {})
    body_hash = body_data_hash(cap_vars, release_data = {}, extra_information = {}, data = {})

    subject       "#{config[:subject_prepend]}[#{cap_vars.first[:rails_env].upcase}][#{body_hash[:repo_end]}] #{body_hash[:inferred_command]}#{config[:subject_append]}"
    recipients    config[:recipient_addresses]
    from          config[:sender_address]
    content_type  config[:email_content_type]

    body          body_hash
  end

  private

    def body_data_hash(cap_vars, release_data = {}, extra_information = {}, data = {})
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
      puts "CAP VARS: #{cap_vars.inspect}"
      data.merge({
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
        :site_name => config[:site_name],
        :application => cap_vars.first[:application],
        :sections => config[:sections]
      })
      return data
    end

end
