set :application, 'capistrano-rails-artifact'

#The Vagrantfile used python to start a simple server serving contents of /vagrant/test (which is actually this project's test directory)
set :rails_artifact_archive_location, 'http://127.0.0.1:8080/test-build-artifact.tar.gz'

set :rails_artifact_group, 'rails_runners'

set :deploy_to, '/tmp/capistrano-rails-artifact'

set :scm, :rails_artifact

set :keep_releases, 2 #we make this low so we can test that the cleanup of release dirs works
