# This file will be included by default when someone sets the scm to be :rails_artifact

load File.expand_path('../tasks/rails_artifact.rake', __FILE__)

# See SSHKit documentation for an explanation. Essentially, whenever someone says "execute :cmd" this code
# will make the command 'cmd' run as the unprivileged 'rails' user. If you prepend the command with privileged_, then
# it will run as the current user (which is thought to be privileged enough to at least run sudo)
SSHKit.config.command_map = Hash.new do |hash, command|
  if %w{if test time}.include? command.to_s
    hash[command] = "sudo -E -u rails #{command}"
  elsif command.to_s.start_with?("privileged")
    hash[command] = command.to_s.sub(/privileged_/, '')
  else
    command = "bundle exec #{command}" if %w{rake rails gem}.include? command.to_s.split.first
    hash[command] = "sudo -E -u rails /usr/bin/env #{command}"
  end
end

# Necessary since SHKit's 'test()'' does not go through the command map above and thus will run as your user, not rails
module OverrideTestToUseRailsUser
  def test(*args)
    if args.size == 1 && args.first.is_a?(String)
      args[0] = "sudo -E -u rails #{args.first}"
    end
    super(*args)
  end
end
SSHKit::Backend::Netssh.send(:prepend, OverrideTestToUseRailsUser)

# These two tasks are unnecessary for this strategy
Rake::Task['deploy:log_revision'].clear
Rake::Task['deploy:set_current_revision'].clear
namespace :deploy do
  task :set_current_revision do
  end
  task :log_revision do
  end
end
