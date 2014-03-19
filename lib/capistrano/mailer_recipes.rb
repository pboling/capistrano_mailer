Capistrano::Configuration.instance(:must_exist).load do

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

      # These are overridden by the configuration in the block:
      #   CapMailer.configure do |config|
      #     config[:attach_log_on] = [:failure]
      #   end
      mailer.send_notification_email(self, {
        #:attach_log_on => [:success, :failure],
        :release_notes => release_notes
      })
    end

    # This is to test hte cap mailer notification system.
    # Execute:
    #   bundle exec cap staging deploy:nothing
    task :nothing, :roles => :app do
      puts "DOING NOTHING!"
      set :release_notes, "No Changes since last deploy."
    end

  end

  after "deploy", "deploy:notify"

  after "deploy:nothing", "deploy:notify"

end
