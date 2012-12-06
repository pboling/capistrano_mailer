namespace :show do
  task :me do
    set :task_name, task_call_frames.first.task.fully_qualified_name
  end
end

namespace :deploy do
  desc "Send email notification of deployment (only send variables you want to be in the email)"
  task :notify, :roles => :app do
    show.me  # this sets the task_name variable
    
    # Set the release notes
    git_commits_range = "#{previous_revision.strip}..#{current_revision.strip}"
    git_log = `git log --pretty=oneline --abbrev-commit #{git_commits_range}` # executes in local shell
    set :release_notes, git_log.blank? ? "No Changes since last deploy." : "from git\n" + git_log
    
    mailer.send_notification_email(self)
  end
end

after "deploy", "deploy:notify"