role :app, %w{deploy_target}
role :web, %w{deploy_target}

# Sets up Capistrano to be able to deploy into your vagrant box
require 'tempfile'
tempfile = Tempfile.open('vagrant-ssh-config')

system("vagrant ssh-config > #{tempfile.path}")

unless $?.success?
  puts "You need to `vagrant up` first!"
  exit(1)
end

set :ssh_options, {
    config: [tempfile.path]
}
