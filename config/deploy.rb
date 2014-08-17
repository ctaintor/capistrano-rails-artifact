# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'capistrano-rails-artifact'

set :build_artifact_location, '/vagrant/test/test-build-artifact.tar.gz'

set :deploy_to, '/tmp/capistrano-rails-artifact'

set :scm, :rails_artifact

set :keep_releases, 2 #we make this low so we can test that the cleanup of release dirs works

namespace :deploy do

  # This task is basically performed by Chef in our production environments
  task :create_rails_user do
    on release_roles :all do
      unless test("[ -d /home/rails ]")
        execute(:sudo, 'groupadd rails_runners')
        execute(:sudo, 'useradd -G rails_runners rails')
        execute(:sudo, 'usermod -a -G rails_runners vagrant')
      end
    end
  end
  after :started, :create_rails_user

end
